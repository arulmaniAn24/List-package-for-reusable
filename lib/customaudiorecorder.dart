import 'package:audiorecorder/audiocard.dart';
import 'package:audiorecorder/audiowave.dart';
import 'package:audiorecorder/bloc/bloc.dart';
import 'package:audiorecorder/bloc/blocevent.dart';
import 'package:audiorecorder/bloc/blocstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  List<String> _recordedFiles = [];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _recorder = FlutterSoundRecorder();
    _recordedFiles = [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  String _timerText(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioRecorderBloc(),
      child: BlocConsumer<AudioRecorderBloc, AudioRecorderState>(
        listener: (context, state) {
          if (state is AudioRecordingStarted) {
            _startTimer(state.duration);
          } else if (state is AudioRecorderStopped) {
            _stopTimer();

            setState(() {
              isRecording = false;

              _recordedFiles.clear();
              _recordedFiles.addAll(state.recordedFiles);
            });
          } else if (state is AudioRecordingPlaying) {
            setState(() {
              _currentPlayingIndex = state.playingIndex;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                          top: 14,
                          right: 4,
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
                      width: MediaQuery.of(context).size.width * 0.90,
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
                            context
                                .read<AudioRecorderBloc>()
                                .add(StartRecording());
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is! AudioRecordingStarted) ...[
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
                                  const SizedBox(width: 20),
                                  Text(
                                    _timerText(state.duration),
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
                                      context
                                          .read<AudioRecorderBloc>()
                                          .add(StopRecording());

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
                    const SizedBox(height: 12),
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
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                              final isPlaying = _currentPlayingIndex == index &&
                                  state is AudioRecordingPlaying;
                              final isPaused = state is AudioPlayerPaused;
                              return AudioFileCard(
                                fileName: fileName,
                                fileSize: fileSize,
                                playRecording: () {
                                  if (isPlaying) {
                                    context
                                        .read<AudioRecorderBloc>()
                                        .add(PausePlaying());
                                  } else {
                                    context
                                        .read<AudioRecorderBloc>()
                                        .add(PlayRecording(index));
                                  }
                                },
                                deleteRecording: () => context
                                    .read<AudioRecorderBloc>()
                                    .add(DeleteRecording(index)),
                                isPlaying: isPlaying,
                                isPaused: isPaused,
                              );
                            } catch (e) {
                              print(
                                  'Error in GridView.builder at index $index: $e');
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
        },
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

  void _startTimer(Duration duration) {}

  void _stopTimer() {}
}
