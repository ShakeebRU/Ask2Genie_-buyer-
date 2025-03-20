// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';

// import '../../utils/constants.dart';

// class AudioPlayerDialog extends StatefulWidget {
//   final FlutterSoundPlayer player;
//   final String tempPath;

//   const AudioPlayerDialog({
//     Key? key,
//     required this.player,
//     required this.tempPath,
//   }) : super(key: key);

//   @override
//   _AudioPlayerDialogState createState() => _AudioPlayerDialogState();
// }

// class _AudioPlayerDialogState extends State<AudioPlayerDialog> {
//   bool isPlaying = false;
//   bool isProgressAvailable = false;
//   Duration currentDuration = Duration.zero;
//   Duration totalDuration = Duration.zero;
//   StreamSubscription<PlaybackDisposition>? progressSubscription;

//   @override
//   void initState() {
//     super.initState();
//     checkProgressStream();
//   }

//   void checkProgressStream() {
//     if (widget.player.onProgress != null) {
//       print("Progress stream available");
//       progressSubscription = widget.player.onProgress!.listen((progress) {
//         setState(() {
//           currentDuration = progress.position;
//           totalDuration = progress.duration;
//         });
//       });
//       setState(() {
//         isProgressAvailable = true;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     progressSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Constants.secondaryColor,
//       title: Text(
//         "Play Audio",
//         style: TextStyle(
//           color: Constants.primaryColor,
//           fontFamily: GoogleFonts.antic().fontFamily,
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (!isProgressAvailable)
//             Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(Constants.primaryColor),
//               ),
//             )
//           else ...[
//             // Waveform visualization
//             SizedBox(
//               height: 100,
//               child: WaveWidget(
//                 config: CustomConfig(
//                   gradients: [
//                     [Constants.primaryColor, Constants.secondaryColor],
//                     [Constants.textColor, Constants.primaryColor],
//                   ],
//                   durations: [3500, 1940],
//                   heightPercentages: [0.2, 0.3],
//                   blur: const MaskFilter.blur(BlurStyle.solid, 3),
//                   gradientBegin: Alignment.centerLeft,
//                   gradientEnd: Alignment.centerRight,
//                 ),
//                 waveAmplitude: 0,
//                 size: const Size(double.infinity, double.infinity),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Play and pause button
//             IconButton(
//               icon: Icon(
//                 isPlaying ? Icons.pause : Icons.play_arrow,
//                 color: Constants.primaryColor,
//                 size: 40,
//               ),
//               onPressed: () async {
//                 if (!isPlaying) {
//                   await widget.player.startPlayer(
//                     fromURI: widget.tempPath,
//                     codec: Codec.aacADTS,
//                     whenFinished: () {
//                       setState(() {
//                         isPlaying = false;
//                         currentDuration = Duration.zero;
//                       });
//                     },
//                   );
//                   setState(() {
//                     isPlaying = true;
//                   });
//                 } else {
//                   await widget.player.pausePlayer();
//                   setState(() {
//                     isPlaying = false;
//                   });
//                 }
//               },
//             ),
//             // Progress slider
//             // Column(
//             //   children: [
//             //     Slider(
//             //       value: currentDuration.inMilliseconds.toDouble(),
//             //       min: 0,
//             //       max: totalDuration.inMilliseconds.toDouble(),
//             //       onChanged: (value) async {
//             //         await widget.player.seekToPlayer(
//             //           Duration(milliseconds: value.toInt()),
//             //         );
//             //         setState(() {
//             //           currentDuration = Duration(milliseconds: value.toInt());
//             //         });
//             //       },
//             //     ),
//             //     Text(
//             //       "${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')} / "
//             //       "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
//             //       style: TextStyle(
//             //         color: Constants.primaryColor,
//             //         fontFamily: GoogleFonts.antic().fontFamily,
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           ],
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () async {
//             await widget.player.stopPlayer();
//             progressSubscription?.cancel();
//             Navigator.pop(context);
//           },
//           child: Text(
//             "Close",
//             style: TextStyle(
//               color: Constants.textColor,
//               fontFamily: GoogleFonts.antic().fontFamily,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../utils/constants.dart';

class AudioPlayerDialog extends StatefulWidget {
  final FlutterSoundPlayer player;
  final String source; // Source can be a file path or URL
  final bool isUrl; // Specify if the source is a URL

  const AudioPlayerDialog({
    Key? key,
    required this.player,
    required this.source,
    this.isUrl = false, // Default to a file path
  }) : super(key: key);

  @override
  _AudioPlayerDialogState createState() => _AudioPlayerDialogState();
}

class _AudioPlayerDialogState extends State<AudioPlayerDialog> {
  bool isPlaying = false;
  bool isProgressAvailable = false;
  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;
  StreamSubscription<PlaybackDisposition>? progressSubscription;

  @override
  void initState() {
    super.initState();
    checkProgressStream();
  }

  void checkProgressStream() {
    if (widget.player.onProgress != null) {
      progressSubscription = widget.player.onProgress!.listen((progress) {
        setState(() {
          currentDuration = progress.position;
          totalDuration = progress.duration;
        });
      });
      setState(() {
        isProgressAvailable = true;
      });
    }
  }

  @override
  void dispose() {
    progressSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Constants.secondaryColor,
      title: Text(
        "Play Audio",
        style: TextStyle(
          color: Constants.primaryColor,
          fontFamily: GoogleFonts.antic().fontFamily,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isProgressAvailable)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Constants.primaryColor),
              ),
            )
          else ...[
            // Waveform visualization
            SizedBox(
              height: 100,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Constants.primaryColor, Constants.secondaryColor],
                    [Constants.textColor, Constants.primaryColor],
                  ],
                  durations: [3500, 1940],
                  heightPercentages: [0.2, 0.3],
                  blur: const MaskFilter.blur(BlurStyle.solid, 3),
                  gradientBegin: Alignment.centerLeft,
                  gradientEnd: Alignment.centerRight,
                ),
                waveAmplitude: 0,
                size: const Size(double.infinity, double.infinity),
              ),
            ),
            const SizedBox(height: 20),
            // Play and pause button
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Constants.primaryColor,
                size: 40,
              ),
              onPressed: () async {
                if (!isPlaying) {
                  await widget.player.startPlayer(
                    fromURI: widget.source,
                    codec: widget.isUrl ? Codec.mp3 : Codec.aacADTS,
                    whenFinished: () {
                      setState(() {
                        isPlaying = false;
                        currentDuration = Duration.zero;
                      });
                    },
                  );
                  setState(() {
                    isPlaying = true;
                  });
                } else {
                  await widget.player.pausePlayer();
                  setState(() {
                    isPlaying = false;
                  });
                }
              },
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await widget.player.stopPlayer();
            progressSubscription?.cancel();
            Navigator.pop(context);
          },
          child: Text(
            "Close",
            style: TextStyle(
              color: Constants.textColor,
              fontFamily: GoogleFonts.antic().fontFamily,
            ),
          ),
        ),
      ],
    );
  }
}
