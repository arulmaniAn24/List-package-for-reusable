import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audiorecorder/audiocard.dart';
import 'package:audiorecorder/audiowave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/colors.dart';

class CustomAudioRecorder extends StatefulWidget {
  const CustomAudioRecorder({super.key});

  @override
  State<CustomAudioRecorder> createState() => _CustomAudioRecorderState();
}

class _CustomAudioRecorderState extends State<CustomAudioRecorder>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool isRecording = false;
  int? _currentPlayingIndex;

  late Timer _timer;
  int _start = 0;
  final List<String> _recordedFiles = [];
  String? _filePath;
  late AnimationController _controller;
//late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // _waveAnimation =
    //     Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOut,
    // ));

    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _initializeRecorder();
    _loadRecordedFiles();
  }

  Future<void> _initializeRecorder() async {
    try {
      var micStatus = await Permission.microphone.request();
      if (micStatus != PermissionStatus.granted) {
        throw 'Microphone permission not granted';
      }

      if (Platform.isAndroid &&
          (await Permission.storage.isPermanentlyDenied ||
              await Permission.manageExternalStorage.isPermanentlyDenied)) {
        openAppSettings();
        return;
      }

      if (Platform.isAndroid && await Permission.storage.request().isGranted) {
        await Permission.manageExternalStorage.request();
      } else if (Platform.isIOS) {
        await Permission.photos.request();
      }

      await _recorder!.openRecorder();
      await _player!.openPlayer();
    } catch (e) {
      print('Error initializing recorder or player: $e');
    }
  }

  Future<String> _getAppDirectoryPath() async {
    final directory = await getExternalStorageDirectory();
    final appDirectory = Directory('${directory!.path}/MyApp');
    if (!appDirectory.existsSync()) {
      appDirectory.createSync(recursive: true);
    }
    return appDirectory.path;
  }

  Future<String> _getFilePath() async {
    final appDirectoryPath = await _getAppDirectoryPath();
    final now = DateTime.now();
    final fileName =
        'Phoenix-MP3_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}.aac';
    final filePath = '$appDirectoryPath/$fileName';
    print('Generated file path: $filePath');
    return filePath;
  }

  Future<File> _getRecordedFilesListFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/recorded_files.json');
  }

  Future<void> _saveRecordedFiles() async {
    try {
      final file = await _getRecordedFilesListFile();
      await file.writeAsString(jsonEncode(_recordedFiles));
      print('Recorded files saved');
    } catch (e) {
      print('Error saving recorded files: $e');
    }
  }

  String _getReadableFileSize(int bytes) {
    const int KB = 1024;
    const int MB = KB * 1024;
    if (bytes >= MB) {
      return '${(bytes / MB).toStringAsFixed(2)} MB';
    } else if (bytes >= KB) {
      return '${(bytes / KB).toStringAsFixed(2)} KB';
    } else {
      return '$bytes bytes';
    }
  }

  Future<void> _loadRecordedFiles() async {
    try {
      final file = await _getRecordedFilesListFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        setState(() {
          _recordedFiles.clear();
          _recordedFiles.addAll(jsonList.cast<String>());
        });
        print('Loaded files: $_recordedFiles');
      }
    } catch (e) {
      print('Error loading recorded files: $e');
    }
  }

  String get _timerText {
    final minutes = _start ~/ 60;
    final seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start >= 120) {
        stopTimer();
        _saveRecordedFiles();
        setState(() {
          isRecording = false;
        });
      } else {
        if (mounted) {
          setState(() {
            _start++;
          });
        }
      }
    });
    _controller.forward(from: 0.0);
  }

  void stopTimer() {
    _timer.cancel();
    _controller.stop();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startRecording() async {
    try {
      _filePath = await _getFilePath();
      await _recorder!.startRecorder(toFile: _filePath);
      setState(() {
        isRecording = true;
      });
      print('Recording started: $_filePath');
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  void _stopRecording() async {
    try {
      await _recorder!.stopRecorder();
      if (_filePath != null) {
        final relativeFilePath = _filePath!.split('/MyApp/').last;
        final file = File(_filePath!);
        final fileSize = await file.length();
        final readableFileSize = _getReadableFileSize(fileSize);
        setState(() {
          _recordedFiles.add('$relativeFilePath:$readableFileSize');
          isRecording = false;
        });
        print('Recording stopped: $_filePath, Size: $readableFileSize');
        await _saveRecordedFiles();
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<String> _getFullPath(String relativePath) async {
    final appDirectoryPath = await _getAppDirectoryPath();
    return '$appDirectoryPath/$relativePath';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Audio Upload',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: SvgPicture.asset(
                        isExpanded
                            ? 'assets/images/arrowdown.svg'
                            : 'assets/images/arrowup.svg',
                        height: 10,
                        width: 10,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  border: Border.all(
                    color: AppColors.secondary3Color,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isRecording = !isRecording;
                    });
                    if (isRecording) {
                      _startRecording();
                      _start = 0;
                      startTimer();
                    } else {
                      _stopRecording();
                      stopTimer();
                      _saveRecordedFiles();
                      print('Recording stopped');
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isRecording) ...[
                        SvgPicture.asset(
                          'assets/images/mic.svg',
                          height: 25,
                          width: 25,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Record Audio',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary3Color,
                          ),
                        ),
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SoundWaveAnimation(isPlaying: isRecording),
                            // TweenAnimationBuilder<double>(
                            //   tween: Tween<double>(begin: 0.8, end: 1.2),
                            //   duration: const Duration(seconds: 2),
                            //   curve: Curves.easeInToLinear,
                            //   builder: (context, value, child) {
                            //     return Transform.scale(
                            //       scale: isRecording ? value : 1.0,
                            //       child: SvgPicture.asset(
                            //         'assets/images/audio_wave.svg',
                            //         height: MediaQuery.of(context).size.height *
                            //             0.04,
                            //         width: MediaQuery.of(context).size.width *
                            //             0.04,
                            //         fit: BoxFit.contain,
                            //       ),
                            //     );
                            //   },
                            // ),
                            const SizedBox(width: 20),
                            Text(
                              _timerText,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isRecording = false;
                                });
                                _stopRecording();
                                stopTimer();
                                _saveRecordedFiles();

                                print('Recording stopped');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 25),
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Stop',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoContainer('AAC', isFirst: true),
                  const SizedBox(width: 4),
                  _buildInfoContainer('2mins', isFirst: false),
                ],
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: Container(),
                secondChild: GridView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.6 / 2,
                  ),
                  itemCount: _recordedFiles.length,
                  itemBuilder: (context, index) {
                    try {
                      final fileData = _recordedFiles[index].split(':');
                      final fileName = fileData[0];
                      final fileSize = fileData[1];
                      bool isPlaying =
                          _currentPlayingIndex == index && _player!.isPlaying;
                      return AudioFileCard(
                        fileName: fileName,
                        fileSize: fileSize,
                        playRecording: () => _playRecording(index),
                        deleteRecording: () => _deleteSpecificRecording(index),
                        isPlaying: isPlaying,
                      );
                    } catch (e) {
                      print('Error in GridView.builder at index $index: $e');
                      return Container(
                        color: AppColors.backgroundColor,
                        child: Center(
                          child: Text(
                            'Error: $e',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String text, {required bool isFirst}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: isFirst ? 4 : 2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: text == 'AAC'
              ? AppColors.secondary3Color
              : AppColors.backgroundColor,
          border: Border.all(color: AppColors.secondary3Color),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }

  void _playRecording(int index) async {
    if (_player == null) {
      print('Player is not initialized');
      return;
    }

    if (_player!.isPlaying) {
      await _player!.stopPlayer();
      setState(() {
        _currentPlayingIndex = null;
      });
    } else {
      if (index < 0 || index >= _recordedFiles.length) {
        print('Invalid index for playback: $index');
        return;
      }
      final relativePath = _recordedFiles[index].split(':').first;
      final fullPath = await _getFullPath(relativePath);
      if (await File(fullPath).exists()) {
        await _player!.startPlayer(
          fromURI: fullPath,
          whenFinished: () {
            if (mounted) {
              setState(() {
                _currentPlayingIndex = null;
              });
            }
          },
        );
        setState(() {
          _currentPlayingIndex = index;
        });
      } else {
        print('File not found: $fullPath');
      }
    }
  }

  void _deleteSpecificRecording(int index) async {
    if (index < 0 || index >= _recordedFiles.length) {
      print('Invalid index provided for deletion');
      return;
    }

    final relativeFilePath = _recordedFiles[index].split(':').first;
    final fullPath = await _getFullPath(relativeFilePath);
    final file = File(fullPath);
    if (await file.exists()) {
      try {
        if (_currentPlayingIndex == index && _player!.isPlaying) {
          await _player!.stopPlayer();
          setState(() {
            _currentPlayingIndex = null;
          });
        }

        await file.delete();
        setState(() {
          _recordedFiles.removeAt(index);
        });
        print('File deleted: $fullPath');
        await _saveRecordedFiles();
      } catch (e) {
        print('Error deleting file: $e');
      }
    } else {
      print('File does not exist: $fullPath');
    }
  }
}
