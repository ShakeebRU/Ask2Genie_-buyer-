import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/query/buyer_notification_list_model.dart';
import '../views/components/audio_widget.dart';
import '../views/components/select_seller_dailog.dart';
import '../views/components/video_widget.dart';
import 'constants.dart';

class Utils {
  static Future<bool> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    return status.isGranted ? true : false;
  }

  static String getTimeElapsed(String dateTimeString) {
    try {
      // Parse the input date-time string
      DateTime dateTime = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();

      // Calculate the difference
      Duration difference = now.difference(dateTime);

      // Convert to human-readable format
      if (difference.inSeconds < 60) {
        return "${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago";
      } else if (difference.inDays < 30) {
        return "${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago";
      } else if (difference.inDays < 365) {
        int months = (difference.inDays / 30).floor();
        return "$months month${months == 1 ? '' : 's'} ago";
      } else {
        int years = (difference.inDays / 365).floor();
        return "$years year${years == 1 ? '' : 's'} ago";
      }
    } catch (e) {
      throw Exception("Invalid date-time string: $e");
    }
  }

  static Map<String, String> formatDateTime(String dateTimeString) {
    try {
      // Parse the input date-time string
      DateTime dateTime = DateTime.parse(dateTimeString);

      // Format the date as "TUE 19 Dec 2024"
      String formattedDate = DateFormat('EEE dd MMM yyyy').format(dateTime);

      // Format the time as "09:25 AM"
      String formattedTime = DateFormat('hh:mm a').format(dateTime);

      return {'date': formattedDate, 'time': formattedTime};
    } catch (e) {
      throw Exception('Invalid date-time string: $e');
    }
  }

  static Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }

  static Future<bool> showConfirmationDialog(
      BuildContext context, DateTime validityDate) async {
    // Format the date to "12 May 2024"
    String formattedDate = DateFormat("d MMMM yyyy").format(validityDate);

    return await showDialog(
          context: context,
          barrierDismissible: false, // Prevent closing by tapping outside
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Validity"),
              content: Text("Your query validity is $formattedDate"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pop(false), // Return false if changing
                  child: Text("Change"),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Return true if OK
                  child:
                      Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed unexpectedly
  }

  static Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  static Future<String> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    debugPrint(placemarks.first.toString());
    Placemark place = placemarks[0];
    String address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return address;
  }

  static Future<NotificationModel?> showSelectNotificationDialog(
      BuildContext context, List<NotificationModel> notificationsList) async {
    NotificationModel? result = await showDialog(
      context: context,
      builder: (context) =>
          SelectNotificationDialog(notificationsList: notificationsList),
    );

    if (result != null) {
      print("Notification selected!");
      return result;
    } else {
      print("No notification selected.");
      return null;
    }
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          backgroundColor: Colors.red,
          forwardAnimationCurve: Curves.decelerate,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          flushbarPosition: FlushbarPosition.TOP,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
          message: message,
        )..show(context));
  }

  // static checkStoragePermission() async {
  //   final notiStatus = await Permission.notification.status;
  //   if (!notiStatus.isGranted) {
  //     if (Platform.isAndroid && Platform.version.contains('13')) {
  //       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //           FlutterLocalNotificationsPlugin();
  //       flutterLocalNotificationsPlugin
  //           .resolvePlatformSpecificImplementation<
  //               AndroidFlutterLocalNotificationsPlugin>()
  //           ?.requestNotificationsPermission();
  //     } else {
  //       await Permission.notification.request();
  //     }
  //   }
  // }

  static Future<String?> pickImage({required bool useCamera}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
        source: useCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (image == null) return null;
      File imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);

      return base64String;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  static void flushBarSuccessfulMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          backgroundColor: Colors.green,
          forwardAnimationCurve: Curves.decelerate,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          flushbarPosition: FlushbarPosition.TOP,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
          message: message,
        )..show(context));
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 60,
            width: 180,
            margin: const EdgeInsets.all(10),
            color: Constants.primaryColor,
            child: Row(
              // mainAxisSize: MainAxisSize.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loading',
                  style: TextStyle(
                      color: Constants.secondaryColor,
                      fontSize: 12.0,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(width: 16.0),
                CircularProgressIndicator(
                  color: Constants.secondaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // static Future<void> playBase64AudioWithControls(
  //     BuildContext context, String base64Audio) async {
  //   final FlutterSoundPlayer player = FlutterSoundPlayer();
  //   bool isPlaying = false;
  //   Duration currentDuration = Duration.zero;
  //   Duration totalDuration = Duration.zero;

  //   Uint8List audioBytes = base64Decode(base64Audio);
  //   String tempPath = "${Directory.systemTemp.path}/temp_audio.aac";
  //   await File(tempPath).writeAsBytes(audioBytes);

  //   await player.openPlayer();

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           // Start a listener for playback progress
  //           player.onProgress?.listen((PlaybackDisposition progress) {
  //             currentDuration = progress.position;
  //             totalDuration = progress.duration;
  //             setState(() {});
  //           });

  //           return AlertDialog(
  //             backgroundColor: Constants.secondaryColor,
  //             title: Text(
  //               "Play Audio",
  //               style: TextStyle(
  //                 color: Constants.primaryColor,
  //                 fontFamily: GoogleFonts.antic().fontFamily,
  //               ),
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Waveform visualization
  //                 SizedBox(
  //                   height: 100,
  //                   child: WaveWidget(
  //                     config: CustomConfig(
  //                       gradients: [
  //                         [Constants.primaryColor, Constants.secondaryColor],
  //                         [Constants.textColor, Constants.primaryColor],
  //                       ],
  //                       durations: [3500, 1940],
  //                       heightPercentages: [0.2, 0.3],
  //                       blur: const MaskFilter.blur(BlurStyle.solid, 3),
  //                       gradientBegin: Alignment.centerLeft,
  //                       gradientEnd: Alignment.centerRight,
  //                     ),
  //                     waveAmplitude: 0,
  //                     size: const Size(double.infinity, double.infinity),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 // Play and pause button
  //                 IconButton(
  //                   icon: Icon(
  //                     isPlaying ? Icons.pause : Icons.play_arrow,
  //                     color: Constants.primaryColor,
  //                     size: 40,
  //                   ),
  //                   onPressed: () async {
  //                     if (!isPlaying) {
  //                       await player.startPlayer(
  //                         fromURI: tempPath,
  //                         codec: Codec.aacADTS,
  //                         whenFinished: () {
  //                           setState(() {
  //                             isPlaying = false;
  //                           });
  //                         },
  //                       );
  //                       setState(() {
  //                         isPlaying = true;
  //                       });
  //                     } else {
  //                       await player.pausePlayer();
  //                       setState(() {
  //                         isPlaying = false;
  //                       });
  //                     }
  //                   },
  //                 ),

  //                 // Progress slider
  //                 Column(
  //                   children: [
  //                     Slider(
  //                       value: currentDuration.inMilliseconds.toDouble(),
  //                       min: 0,
  //                       max: totalDuration.inMilliseconds.toDouble(),
  //                       onChanged: (value) async {
  //                         await player.seekToPlayer(
  //                             Duration(milliseconds: value.toInt()));
  //                       },
  //                     ),
  //                     Text(
  //                       "${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')} / "
  //                       "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
  //                       style: TextStyle(
  //                         color: Constants.primaryColor,
  //                         fontFamily: GoogleFonts.antic().fontFamily,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () async {
  //                   await player.stopPlayer();
  //                   setState(() {
  //                     isPlaying = false;
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   "Close",
  //                   style: TextStyle(
  //                     color: Constants.textColor,
  //                     fontFamily: GoogleFonts.antic().fontFamily,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );

  //   await player.closePlayer();
  // }

  static Future<void> playBase64AudioWithControls(
      BuildContext context, String base64Audio, bool isUrl) async {
    final FlutterSoundPlayer player = FlutterSoundPlayer();
    String tempPath = "${Directory.systemTemp.path}/temp_audio.aac";
    if (!isUrl) {
      Uint8List audioBytes = base64Decode(base64Audio);
      // String tempPath = "${Directory.systemTemp.path}/temp_audio.aac";
      await File(tempPath).writeAsBytes(audioBytes);
    } else {
      tempPath = base64Audio;
    }
    await player.openPlayer();
    await showDialog(
      context: context,
      builder: (context) => AudioPlayerDialog(
        player: player,
        source: tempPath,
        isUrl: isUrl,
      ),
    );

    await player.closePlayer();
  }

  // static Future<void> playBase64AudioWithControls(
  //     BuildContext context, String base64Audio) async {
  //   final FlutterSoundPlayer player = FlutterSoundPlayer();
  //   bool isPlaying = false;
  //   Duration currentDuration = Duration.zero;
  //   Duration totalDuration = Duration.zero;

  //   Uint8List audioBytes = base64Decode(base64Audio);
  //   String tempPath = "${Directory.systemTemp.path}/temp_audio.aac";
  //   await File(tempPath).writeAsBytes(audioBytes);

  //   await player.openPlayer();

  //   StreamSubscription<PlaybackDisposition>? progressSubscription;
  //   bool isProgressAvailable = false;

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           // Continuously check for progress stream availability
  //           if (!isProgressAvailable && player.onProgress != null) {
  //             progressSubscription = player.onProgress!.listen((progress) {
  //               currentDuration = progress.position;
  //               totalDuration = progress.duration;
  //               setState(() {});
  //             });
  //             setState(() {
  //               isProgressAvailable = true;
  //             });
  //           }

  //           return AlertDialog(
  //             backgroundColor: Constants.secondaryColor,
  //             title: Text(
  //               "Play Audio",
  //               style: TextStyle(
  //                 color: Constants.primaryColor,
  //                 fontFamily: GoogleFonts.antic().fontFamily,
  //               ),
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Show a loading indicator if progress stream is not yet available
  //                 if (!isProgressAvailable)
  //                   Center(
  //                     child: CircularProgressIndicator(
  //                       valueColor:
  //                           AlwaysStoppedAnimation(Constants.primaryColor),
  //                     ),
  //                   )
  //                 else ...[
  //                   // Waveform visualization
  //                   SizedBox(
  //                     height: 100,
  //                     child: WaveWidget(
  //                       config: CustomConfig(
  //                         gradients: [
  //                           [Constants.primaryColor, Constants.secondaryColor],
  //                           [Constants.textColor, Constants.primaryColor],
  //                         ],
  //                         durations: [3500, 1940],
  //                         heightPercentages: [0.2, 0.3],
  //                         blur: const MaskFilter.blur(BlurStyle.solid, 3),
  //                         gradientBegin: Alignment.centerLeft,
  //                         gradientEnd: Alignment.centerRight,
  //                       ),
  //                       waveAmplitude: 0,
  //                       size: const Size(double.infinity, double.infinity),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 20),
  //                   // Play and pause button
  //                   IconButton(
  //                     icon: Icon(
  //                       isPlaying ? Icons.pause : Icons.play_arrow,
  //                       color: Constants.primaryColor,
  //                       size: 40,
  //                     ),
  //                     onPressed: () async {
  //                       if (!isPlaying) {
  //                         await player.startPlayer(
  //                           fromURI: tempPath,
  //                           codec: Codec.aacADTS,
  //                           whenFinished: () {
  //                             setState(() {
  //                               isPlaying = false;
  //                               currentDuration = Duration.zero;
  //                             });
  //                           },
  //                         );
  //                         setState(() {
  //                           isPlaying = true;
  //                         });
  //                       } else {
  //                         await player.pausePlayer();
  //                         setState(() {
  //                           isPlaying = false;
  //                         });
  //                       }
  //                     },
  //                   ),
  //                   // Progress slider
  //                   Column(
  //                     children: [
  //                       Slider(
  //                         value: currentDuration.inMilliseconds.toDouble(),
  //                         min: 0,
  //                         max: totalDuration.inMilliseconds.toDouble(),
  //                         onChanged: (value) async {
  //                           await player.seekToPlayer(
  //                             Duration(milliseconds: value.toInt()),
  //                           );
  //                           setState(() {
  //                             currentDuration =
  //                                 Duration(milliseconds: value.toInt());
  //                           });
  //                         },
  //                       ),
  //                       Text(
  //                         "${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')} / "
  //                         "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
  //                         style: TextStyle(
  //                           color: Constants.primaryColor,
  //                           fontFamily: GoogleFonts.antic().fontFamily,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () async {
  //                   await player.stopPlayer();
  //                   progressSubscription?.cancel();
  //                   progressSubscription = null;
  //                   setState(() {
  //                     isPlaying = false;
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   "Close",
  //                   style: TextStyle(
  //                     color: Constants.textColor,
  //                     fontFamily: GoogleFonts.antic().fontFamily,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );

  //   progressSubscription?.cancel();
  //   await player.closePlayer();
  // }

  static Future<String?> recordAudioAndReturnBase64(
      BuildContext context) async {
    final FlutterSoundRecorder recorder = FlutterSoundRecorder();
    String? base64String;
    bool isRecording = false;
    String? recordedFilePath;

    await recorder.openRecorder();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Constants.secondaryColor,
              title: Text(
                "Record Audio",
                style: TextStyle(
                  color: Constants.primaryColor,
                  fontFamily: GoogleFonts.antic().fontFamily,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isRecording ? Icons.stop : Icons.mic,
                      color: Constants.primaryColor,
                      size: 50,
                    ),
                    onPressed: () async {
                      await Permission.microphone.request();
                      PermissionStatus status =
                          await Permission.microphone.request();
                      if (status.isGranted) {
                        if (!isRecording) {
                          // Start recording
                          recordedFilePath =
                              "${Directory.systemTemp.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";
                          await recorder.startRecorder(
                            toFile: recordedFilePath,
                            codec: Codec.aacADTS,
                          );
                          setState(() {
                            isRecording = true;
                          });
                        } else {
                          // Stop recording
                          await recorder.stopRecorder();
                          setState(() {
                            isRecording = false;
                          });

                          // Convert to Base64
                          if (recordedFilePath != null) {
                            final bytes =
                                await File(recordedFilePath!).readAsBytes();
                            base64String = base64Encode(bytes);
                          }

                          Navigator.pop(context);
                        }
                      } else {
                        Utils.showCustomSnackbar(
                          context: context,
                          title: "Permission Denied",
                          message: "Microphone permission denied",
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                  ),
                  Text(
                    isRecording ? "Recording..." : "Press to Start Recording",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontFamily: GoogleFonts.antic().fontFamily,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (isRecording) {
                      await recorder.stopRecorder();
                      setState(() {
                        isRecording = false;
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Constants.textColor,
                      fontFamily: GoogleFonts.antic().fontFamily,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    await recorder.closeRecorder();
    return base64String;
  }

  static Future<void> showVideoDialog(
      BuildContext context, String base64Video, bool isUrl) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return VideoDialog(
          videoSource: base64Video,
          isUrl: isUrl,
        );
      },
    );
  }

  static Future<String?> pickVideoAndReturnBase64(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    String? base64String;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constants.secondaryColor,
          title: Text(
            "Select Video Source",
            style: TextStyle(
              color: Constants.primaryColor,
              fontFamily: GoogleFonts.antic().fontFamily,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.video_library,
                  color: Constants.primaryColor,
                ),
                title: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontFamily: GoogleFonts.antic().fontFamily,
                  ),
                ),
                onTap: () async {
                  final XFile? video =
                      await picker.pickVideo(source: ImageSource.gallery);

                  if (video != null) {
                    final bytes = await File(video.path).readAsBytes();
                    base64String = base64Encode(bytes);
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.videocam,
                  color: Constants.primaryColor,
                ),
                title: Text(
                  "Camera",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontFamily: GoogleFonts.antic().fontFamily,
                  ),
                ),
                onTap: () async {
                  final XFile? video =
                      await picker.pickVideo(source: ImageSource.camera);

                  if (video != null) {
                    final bytes = await File(video.path).readAsBytes();
                    base64String = base64Encode(bytes);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Constants.textColor,
                  fontFamily: GoogleFonts.antic().fontFamily,
                ),
              ),
            ),
          ],
        );
      },
    );

    return base64String;
  }

  static Future<List<String>> pickImagesAndReturnBase64(
      BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    List<String> base64Strings = [];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constants.secondaryColor,
          title: Text(
            "Select Image Source",
            style: TextStyle(
              color: Constants.primaryColor,
              fontFamily: GoogleFonts.antic().fontFamily,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Constants.primaryColor,
                ),
                title: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontFamily: GoogleFonts.antic().fontFamily,
                  ),
                ),
                onTap: () async {
                  List<XFile> result = await picker.pickMultiImage();
                  Utils.showLoadingDialog(context);
                  if (result.isNotEmpty) {
                    for (var file in result) {
                      final bytes = await File(file.path).readAsBytes();
                      base64Strings.add(base64Encode(bytes));
                    }
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Constants.primaryColor,
                ),
                title: Text(
                  "Camera",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontFamily: GoogleFonts.antic().fontFamily,
                  ),
                ),
                onTap: () async {
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    final bytes = await File(image.path).readAsBytes();
                    base64Strings.add(base64Encode(bytes));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Constants.textColor,
                  fontFamily: GoogleFonts.antic().fontFamily,
                ),
              ),
            ),
          ],
        );
      },
    );

    return base64Strings;
  }

  static void showCustomSnackbar({
    required BuildContext context,
    required String title,
    required String message,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10, // Adjust for status bar
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info,
                    color: Colors.white, size: 24), // Optional icon
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // Add the overlay entry
    overlay.insert(overlayEntry);
    // Remove the overlay entry after the duration
    Future.delayed(duration, () => overlayEntry.remove());
  }
  // static void showCustomSnackbar({
  //   required BuildContext context,
  //   required String title,
  //   required String message,
  //   required Color backgroundColor,
  //   Duration duration = const Duration(seconds: 3),
  // }) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: duration,
  //       backgroundColor: backgroundColor,
  //       content: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Icon(Icons.info,
  //               color: Colors.white, size: 24), // Optional icon
  //           const SizedBox(width: 8), // Spacing between icon and text
  //           Expanded(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                     height: 4), // Spacing between title and message
  //                 Text(
  //                   message,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),

  //       behavior: SnackBarBehavior.floating, // Makes the snackbar float
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     ),
  //   );
  // }

  static Future<void> showconnectivityDialog(
      BuildContext context, Function func) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Network Error'),
          content: const Text(
              'No Internet Connection. Please check your connection and try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => func,
              child: Text(
                'Ok',
                style: TextStyle(color: Constants.textPrimaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
