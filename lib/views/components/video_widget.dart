// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';

// class VideoDialog extends StatefulWidget {
//   final String videoSource;
//   final bool isUrl;

//   const VideoDialog({
//     Key? key,
//     required this.videoSource,
//     this.isUrl = false,
//   }) : super(key: key);

//   @override
//   _VideoDialogState createState() => _VideoDialogState();
// }

// class _VideoDialogState extends State<VideoDialog> {
//   VideoPlayerController? _controller;
//   File? _videoFile;
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     try {
//       if (widget.isUrl) {
//         _controller =
//             VideoPlayerController.networkUrl(Uri.parse(widget.videoSource))
//               ..initialize().then((_) {
//                 setState(() {});
//               }).catchError((error) {
//                 _showErrorDialog("Failed to load the video from URL: $error");
//               });
//       } else {
//         final videoBytes = base64Decode(widget.videoSource);
//         final directory = await getTemporaryDirectory();
//         _videoFile = File('${directory.path}/temp_video.mp4');
//         await _videoFile!.writeAsBytes(videoBytes);

//         _controller = VideoPlayerController.file(_videoFile!)
//           ..initialize().then((_) {
//             setState(() {});
//           }).catchError((error) {
//             _showErrorDialog("Failed to load the video: $error");
//           });
//       }
//       setState(() {});
//     } catch (error) {
//       _showErrorDialog("An error occurred while loading the video.");
//     }
//   }

//   void _togglePlayPause() {
//     if (_controller != null) {
//       setState(() {
//         isPlaying = !isPlaying;
//         isPlaying ? _controller!.play() : _controller!.pause();
//       });
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _closeDialog() {
//     _controller?.dispose();
//     _videoFile?.deleteSync();
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.black,
//       title: const Text(
//         'Video Player',
//         style: TextStyle(color: Colors.white),
//       ),
//       content: _controller != null && _controller!.value.isInitialized
//           ? Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 AspectRatio(
//                   aspectRatio: _controller!.value.aspectRatio,
//                   child: VideoPlayer(_controller!),
//                 ),
//                 VideoProgressIndicator(_controller!, allowScrubbing: true),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: Icon(_controller!.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow),
//                       color: Colors.white,
//                       onPressed: _togglePlayPause,
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.replay),
//                       color: Colors.white,
//                       onPressed: () {
//                         _controller!.seekTo(Duration.zero);
//                         _controller!.play();
//                         setState(() {
//                           isPlaying = true;
//                         });
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.stop),
//                       color: Colors.white,
//                       onPressed: () {
//                         _controller!.pause();
//                         _controller!.seekTo(Duration.zero);
//                         setState(() {
//                           isPlaying = false;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           : const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.blue,
//               ),
//             ),
//       actions: [
//         TextButton(
//           onPressed: _closeDialog,
//           child: const Text(
//             'Close',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     _videoFile?.deleteSync();
//     super.dispose();
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoDialog extends StatefulWidget {
  final String videoSource;
  final bool isUrl;

  const VideoDialog({
    Key? key,
    required this.videoSource,
    this.isUrl = false, // Default to base64 if not specified
  }) : super(key: key);

  @override
  _VideoDialogState createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  VideoPlayerController? _controller;
  bool isPlaying = false;
  File? _videoFile;
  ChewieController? flickManager;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  /// Initialize the video player based on the source type
  Future<void> _initializePlayer() async {
    try {
      if (widget.isUrl) {
        // Initialize controller for URL video
        _controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoSource))
              ..initialize().then((_) {
                setState(() {}); // Rebuild when initialization is complete
              }).catchError((error) {
                _showErrorDialog("Failed to load the video from URL: $error");
              });
      } else {
        // Handle base64-encoded video
        final videoBytes = base64Decode(widget.videoSource);
        final directory = await getTemporaryDirectory();
        _videoFile = File('${directory.path}/temp_video.mp4');
        await _videoFile!.writeAsBytes(videoBytes);

        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {}); // Rebuild when initialization is complete
          }).catchError((error) {
            _showErrorDialog("Failed to load the video: $error");
          });
      }

      // Dispose of previous instance before creating a new one
      flickManager?.dispose();

      // Initialize ChewieController
      flickManager = ChewieController(
        aspectRatio: _controller!.value.aspectRatio,
        videoPlayerController: _controller!,
        autoPlay: false,
        looping: false,
      );

      setState(() {}); // Ensure UI updates
    } catch (error) {
      debugPrint("Error initializing video: $error");
      _showErrorDialog("An error occurred while loading the video.");
    }
  }

  /// Toggle between play and pause
  void _togglePlayPause() {
    if (_controller != null) {
      setState(() {
        isPlaying = !isPlaying;
        isPlaying ? _controller!.play() : _controller!.pause();
      });
    }
  }

  /// Show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  /// Close the dialog and clean up resources
  void _closeDialog() {
    _controller?.dispose();
    flickManager?.dispose();

    // Safely delete the temporary video file
    try {
      _videoFile?.deleteSync();
    } catch (e) {
      debugPrint("Error deleting temporary video file: $e");
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Video Player',
        style: TextStyle(color: Colors.white),
      ),
      content: _controller != null &&
              _controller!.value.isInitialized &&
              flickManager != null
          ? Container(
              height: 250,
              width: 400,
              color: Colors.black,
              child: Chewie(controller: flickManager!),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
      actions: [
        // Close button
        TextButton(
          onPressed: _closeDialog,
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (flickManager != null) {
      flickManager?.dispose();
    }
    _controller?.dispose();
    // Safe delete the temp video file
    try {
      _videoFile?.deleteSync();
    } catch (e) {
      debugPrint("Error deleting temporary video file: $e");
    }

    super.dispose();
  }
}
