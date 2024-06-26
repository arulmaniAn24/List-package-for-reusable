import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audiorecorder/bloc/blocevent.dart';
import 'package:audiorecorder/bloc/blocstate.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderBloc extends Bloc<AudioRecorderEvent, AudioRecorderState> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  Timer? _timer;
  int _start = 0;
  String? _filePath;
  final List<String> _recordedFiles = [];

  AudioRecorderBloc() : super(AudioRecorderInitial()) {
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _initializeRecorder();
    _loadRecordedFiles();

    on<StartRecording>((event, emit) async {
      await _startRecording();
      print("recorder started");
      _start = 0;
      _startTimer();

      emit(AudioRecordingStarted(Duration(seconds: _start)));
    });

    on<StopRecording>((event, emit) async {
      await _stopRecording();
      _stopTimer();
      emit(AudioRecorderStopped(_recordedFiles));
    });

    on<LoadRecordedFiles>((event, emit) async {
      await _loadRecordedFiles();
      emit(AudioRecorderStopped(_recordedFiles));
    });

    on<DeleteRecording>((event, emit) async {
      await _deleteSpecificRecording(event.index);
      emit(AudioRecorderStopped(_recordedFiles));
    });

    on<PlayRecording>((event, emit) async {
      await _playRecording(event.index);
      emit(AudioRecordingPlaying(event.index));
    });

    on<PausePlaying>((event, emit) async {
      if (_player != null && _player!.isPlaying) {
        await _player!.pausePlayer();
        emit(AudioPlayerPaused());
      }
    });

    on<StopPlaying>((event, emit) async {
      if (_player != null) {
        await _player!.stopPlayer();
        emit(AudioPlayerStopped());
      }
    });

    on<TimerStart>((event, emit) async {
      _start++;
      // print('Timer Started:$_start');
      if (_start >= 120) {
        add(StopRecording());
      } else {
        emit(AudioRecordingStarted(Duration(seconds: _start)));
      }
    });
  }

  Future<void> _initializeRecorder() async {
    var micStatus = await Permission.microphone.request();
    if (micStatus != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await _recorder!.openRecorder();
    await _player!.openPlayer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      //   print("Timer triggered");
      add(TimerStart());
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    print("Timer stopped");
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
    return filePath;
  }

  Future<void> _startRecording() async {
    try {
      if (_recorder!.isRecording) {
        return;
      }
      _filePath = await _getFilePath();
      await _recorder!.startRecorder(toFile: _filePath);
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder!.stopRecorder();
      if (_filePath != null) {
        final relativeFilePath = _filePath!.split('/MyApp/').last;
        final file = File(_filePath!);
        final fileSize = await file.length();
        final readableFileSize = _getReadableFileSize(fileSize);
        _recordedFiles.add('$relativeFilePath:$readableFileSize');
        await _saveRecordedFiles();
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _loadRecordedFiles() async {
    try {
      final file = await _getRecordedFilesListFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        _recordedFiles.clear();
        _recordedFiles.addAll(jsonList.cast<String>());
      }
    } catch (e) {
      print('Error loading recorded files: $e');
    }
  }

  Future<File> _getRecordedFilesListFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/recorded_files.json');
  }

  Future<void> _saveRecordedFiles() async {
    try {
      final file = await _getRecordedFilesListFile();
      await file.writeAsString(jsonEncode(_recordedFiles));
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

  Future<void> _playRecording(int index) async {
    if (_player == null) {
      return;
    }

    if (_player!.isPlaying) {
      await _player!.stopPlayer();
      emit(AudioPlayerPaused());
    } else {
      final relativePath = _recordedFiles[index].split(':').first;
      final fullPath = await _getFullPath(relativePath);
      if (await File(fullPath).exists()) {
        await _player!.startPlayer(
          fromURI: fullPath,
          whenFinished: () {
            add(StopPlaying());
          },
        );
        emit(AudioRecordingPlaying(index));
      }
    }
  }

  Future<void> _deleteSpecificRecording(int index) async {
    if (index < 0 || index >= _recordedFiles.length) {
      return;
    }

    final relativeFilePath = _recordedFiles[index].split(':').first;
    final fullPath = await _getFullPath(relativeFilePath);
    final file = File(fullPath);
    if (await file.exists()) {
      try {
        if (_player!.isPlaying) {
          await _player!.stopPlayer();
        }
        await file.delete();
        _recordedFiles.removeAt(index);
        await _saveRecordedFiles();
      } catch (e) {
        print('Error deleting file: $e');
      }
    }
  }

  Future<String> _getFullPath(String relativePath) async {
    final appDirectoryPath = await _getAppDirectoryPath();
    return '$appDirectoryPath/$relativePath';
  }

  @override
  Future<void> close() {
    _player?.closePlayer();
    _recorder?.closeRecorder();
    _stopTimer();
    return super.close();
  }
}
