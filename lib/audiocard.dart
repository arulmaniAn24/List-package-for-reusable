import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audiorecorder/audiowave.dart';
//import 'package:marquee/marquee.dart';
import 'constants/colors.dart';

class AudioFileCard extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final VoidCallback playRecording;
  final VoidCallback deleteRecording;
  final bool isPlaying;

  const AudioFileCard({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.playRecording,
    required this.deleteRecording,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.primary2Color,
        border: Border.all(color: AppColors.secondary3Color),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: isPlaying
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                              child: SoundWaveAnimation(isPlaying: isPlaying)),
                        )
                      : SvgPicture.asset(
                          'assets/images/audio_wave.svg',
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.02,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: playRecording,
                  child: SvgPicture.asset(
                    isPlaying
                        ? 'assets/images/pause.svg'
                        : 'assets/images/play.svg',
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width * 0.02,
                    color: AppColors.secondary5Color,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // isPlaying
                    //     ? SizedBox(
                    //         height: 20,
                    //         width: 60,
                    //         child: Marquee(
                    //           text: fileName,
                    //           style: const TextStyle(
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.bold,
                    //             color: AppColors.secondary2Color,
                    //           ),
                    //           scrollAxis: Axis.horizontal,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           blankSpace: 20.0,
                    //           velocity: 50.0,
                    //           pauseAfterRound: Duration(seconds: 1),
                    //           startPadding: 10.0,
                    //           accelerationDuration: Duration(seconds: 1),
                    //           accelerationCurve: Curves.linear,
                    //           decelerationDuration: Duration(milliseconds: 500),
                    //           decelerationCurve: Curves.easeOut,
                    //         ),
                    //       )
                    //     : Text(
                    //         fileName,
                    //         style: const TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold,
                    //           color: AppColors.secondary2Color,
                    //         ),
                    //       ),
                    Text(
                      fileName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary2Color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fileSize,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: deleteRecording,
              child: SvgPicture.asset(
                'assets/images/cancel.svg',
                height: MediaQuery.of(context).size.height * 0.018,
                width: MediaQuery.of(context).size.width * 0.01,
                color: AppColors.secondary4Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:audiorecorder/audiowave.dart';
// import 'constants/colors.dart';
// import 'scrolltext.dart';

// class AudioFileCard extends StatefulWidget {
//   final String fileName;
//   final String fileSize;
//   final VoidCallback playRecording;
//   final VoidCallback deleteRecording;

//   const AudioFileCard({
//     super.key,
//     required this.fileName,
//     required this.fileSize,
//     required this.playRecording,
//     required this.deleteRecording,
//     required bool isPlaying,
//   });

//   @override
//   _AudioFileCardState createState() => _AudioFileCardState();
// }

// class _AudioFileCardState extends State<AudioFileCard> {
//   bool _isPlaying = false;

//   void _togglePlaying() {
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//     widget.playRecording();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: AppColors.primary2Color,
//         border: Border.all(color: AppColors.secondary3Color),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 15.0),
//                 child: Center(
//                   child: _isPlaying
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: SizedBox(
//                             height: 16,
//                             child: SoundWaveAnimation(isPlaying: _isPlaying),
//                           ),
//                         )
//                       : SvgPicture.asset(
//                           'assets/images/audio_wave.svg',
//                           height: 30,
//                           width: 50,
//                           fit: BoxFit.contain,
//                         ),
//                 ),
//               ),
//               const Spacer(),
//             ],
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: _togglePlaying,
//                   child: SvgPicture.asset(
//                     _isPlaying
//                         ? 'assets/images/pause.svg'
//                         : 'assets/images/play.svg',
//                     height: 25,
//                     width: 25,
//                     color: AppColors.secondary5Color,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _isPlaying
//                         ? SizedBox(
//                             height: 20,
//                             width: 160, 
//                             child: ScrollingText(
//                               text: widget.fileName,
//                               textStyle: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.secondary2Color,
//                               ),
//                               isPlaying: _isPlaying,
//                             ),
//                           )
//                         : Text(
//                             widget.fileName,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.secondary2Color,
//                             ),
//                           ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.fileSize,
//                       style: const TextStyle(
//                         fontSize: 10,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: GestureDetector(
//               onTap: widget.deleteRecording,
//               child: SvgPicture.asset(
//                 'assets/images/cancel.svg',
//                 height: 12,
//                 width: 12,
//                 color: AppColors.secondary4Color,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
