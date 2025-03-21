import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';
import '../../../../controllers/audioController/audio_controller.dart';
import '../../../../controllers/chat/chat_screen_controller.dart';
import '../../../../controllers/image_edittor/image_edittor_controller.dart';
import '../../../../resources/resources.dart';
import '../../../../services/get_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../controllers/auth/query_controller.dart';
import '../../controllers/chat/chat_controller.dart';
import '../../models/query/query_chat_model.dart';
import '../../models/query/query_min_rate_model.dart';
import '../../services/notifications.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../components/image_gellery.dart';
import 'compare_screen.dart';

class ChatPageScreen extends StatefulWidget {
  String name;
  String groupId;
  String fcmToken;
  String queryImage;
  int sellerID;
  bool isActive;
  String profileImage;
  QueryMinRateModel rate;
  ChatPageScreen({
    Key? key,
    required this.name,
    required this.groupId,
    required this.queryImage,
    required this.fcmToken,
    required this.sellerID,
    required this.isActive,
    required this.profileImage,
    required this.rate,
  }) : super(key: key);

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool readySend = false;
  bool _isRecording = false;
  String result = '';
  FlutterSoundRecorder? _soundRecorder;
  SpeechToText speechToText = SpeechToText();
  bool isRecorderInit = false;
  bool showImage = false;
  File? imageFile;
  bool isRecording = false;
  bool loading = false;
  AudioPlayer audioPlayer = AudioPlayer();
  ChatScreenController chatScreenController =
      Get.put<ChatScreenController>(ChatScreenController());
  ChatController chatController = Get.put<ChatController>(ChatController());
  AudioController audioController = Get.put(AudioController());
  CheckConnectionService connectionService = CheckConnectionService();
  String audioURL = "";
  String recordFilePath = "";
  String imageUrl = "";
  String textType = '';
  String audioText = '';
  var isListening = false;
  var text = 'Nothing Recognized';
  TextEditingController message = TextEditingController();
  StreamSubscription? recorderSubscription;
  final ScrollController _scrollController = ScrollController();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // NotificationServices services = NotificationServices();
  String _timerText = '00:00:00';
  bool isOpened = false;
  getFormattedTime({required BuildContext context, required String time}) {
    final date = DateTime.parse(time);
    final timeOfDay = TimeOfDay.fromDateTime(date);
    return timeOfDay.format(context);
  }

  @override
  void initState() {
    _soundRecorder = FlutterSoundRecorder();
    print("profile : ${widget.profileImage}");
    openSound();
    super.initState();
  }

  Future<void> _startRecording() async {
    await _audioRecorder.openRecorder();
    if (await Permission.microphone.request().isGranted) {
      await _audioRecorder.startRecorder(
        toFile: 'temp_audio.mp4',
        codec: Codec.aacMP4,
      );
      setState(() {
        _isRecording = true;
      });
    }
  }

  String recordedFilePath = "";
  Duration? duration;
  Future<void> _stopRecording() async {
    recordedFilePath = await _audioRecorder.stopRecorder() ?? "";
    setState(() {
      _isRecording = false;
    });
  }

  Future<String> convertAudio() async {
    String str = "";
    String filePath = '${recordedFilePath}';
    if (filePath != "") {
      List<int> audioBytes = File(filePath).readAsBytesSync();
      return base64Encode(audioBytes);
    }
    return str;
  }
  //_______________________________

  openSound() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic not allowed');
    }
    await _soundRecorder!.openRecorder();
    _soundRecorder!.setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();
    setState(() {
      isRecorderInit = true;
    });
  }

  Future<String> compressBase64Image(String base64String, int quality) async {
    List<int> bytes = base64.decode(base64String);
    Uint8List uint8List = Uint8List.fromList(bytes);
    final result = await FlutterImageCompress.compressWithList(
      uint8List,
      quality: quality,
    );
    String compressedBase64 = base64Encode(Uint8List.fromList(result));
    print("compress 1__________________");
    return compressedBase64;
  }

  Uint8List decodeBase64String(String base64String) {
    List<int> bytes = base64.decode(base64String);
    return Uint8List.fromList(bytes);
  }

  Future<void> writeBytesToFile(Uint8List bytes, String filePath) async {
    File file = File(filePath);
    await file.writeAsBytes(bytes);
  }

  Future pickImage(String scr) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: scr == 'camera' ? ImageSource.camera : ImageSource.gallery);
      if (pickedImage == null) return;
      File file = File(pickedImage.path);
      final controller =
          Provider.of<ImageCollectionScreenProvider>(context, listen: false);

      controller.images = [];
      controller.setIndex(0);
      List<int> fileBytes = await pickedImage.readAsBytes();
      String base64String = base64Encode(fileBytes);
      var temp = await compressBase64Image(base64String, 70);
      controller.addImage(temp);

      if (controller.images.length != 0) {
        // await Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return const SelectionScreen(
        //     check: false,
        //   );
        // }));
        // Get.to(const SelectionScreen());
        // if (pickedImage == null) return;
        // File file = File(pickedImage.path);
        // List<int> imageBytes = file.readAsBytesSync();
        // String base64Image = base64Encode(imageBytes);
        // final controller =
        //     Provider.of<ImageCollectionScreenProvider>(context, listen: false);

        Get.find<ChatController>().image = controller.images[0];
        sendMessageAPi();
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/image.png';

        Uint8List imageBytes = decodeBase64String(controller.images[0]);

        writeBytesToFile(imageBytes, filePath).then((_) {
          imageFile = File(filePath);
          print("Image saved to $filePath");
        }).catchError((error) {
          print("Error saving image: $error");
        });
        // imageFile = file;
        // await uploadImage().then((value) {
        //   // services.sendNotification(
        //   //     name: chatScreenController.loggedInUserName!,
        //   //     token: widget.fcmToken);
        // });
      } else {
        print(controller.images.length);
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future pickVideo(String scr) async {
    try {
      final pickedVideo = await ImagePicker().pickVideo(
        source: scr == 'camera' ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedVideo == null) return;
      // File file = File(pickedVideo.path);
      textType = MessageType.video;
      List<int> fileBytes = await pickedVideo.readAsBytes();
      String base64String = base64Encode(fileBytes);
      await Get.find<ChatController>().sendMessage(
          qsID: int.parse(widget.groupId),
          chatType: 'Buyer',
          messageType: textType,
          sellerID: widget.sellerID,
          msg: message.text,
          base64File: base64String);
      // await Get.find<ChatController>()
      //     .chatVedioUpload(base64String, widget.groupId);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick video: $e');
    }
  }

  /// Send Message
  sendMessageAPi() async {
    if (Get.find<ChatController>().image != '') {
      textType = "Image";
      message.clear();
      await Get.find<ChatController>().sendMessage(
          qsID: int.parse(widget.groupId),
          chatType: 'Buyer',
          messageType: textType,
          sellerID: widget.sellerID,
          msg: message.text,
          base64File: Get.find<ChatController>().image);
      textType = '';
      setState(() {
        showImage = false;
      });
    }
    if (audioText != '') {
      textType = "Audio";
      message.clear();
      await Get.find<ChatController>().sendMessage(
          qsID: int.parse(widget.groupId),
          chatType: 'Buyer',
          messageType: textType,
          sellerID: widget.sellerID,
          msg: message.text,
          base64File: audioText);
      audioText = '';
      textType = '';
    }

    if (message.text.isNotEmpty == true &&
        Get.find<ChatController>().image == '' &&
        audioText == '') {
      textType = "Text";
      await Get.find<ChatController>().sendMessage(
          qsID: int.parse(widget.groupId),
          chatType: 'Buyer',
          sellerID: widget.sellerID,
          messageType: textType,
          msg: message.text);
      message.clear();
      textType = '';
    }
    message.clear();
    textType = '';
    audioText = '';
  }

  void sendButton({
    required String mesContent,
    required String type,
    //bool readStatus = false,
    //String? userStatus = "Offline",
    String duration = "",
  }) {
    if (mesContent.trim().isNotEmpty) {
      var uuid = const Uuid();
      //Get.find<ChatController>().chatFieldController.clear();
      // Get.find<ChatScreenController>().message(
      //     messageContent: mesContent,
      //     type: type,
      //     messageId: uuid.v1(),
      //     senderId: FirebaseAuth.instance.currentUser!.uid,
      //     groupID: widget.groupId,
      //     duration: duration,
      //     timeStamp: DateTime.now().millisecondsSinceEpoch.toString());

      // if (listScrollController.hasClients) {
      //   listScrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      // }
    } else {
      Get.snackbar('Empty', 'Nothing to Send',
          colorText: R.colors.white, backgroundColor: Colors.red);
      Get.log("Nothing to Send");
      //CustomToast.failToast(message: 'Nothing to send');
    }
  }

  recordSoundApi() async {
    var tempDirectory = await getTemporaryDirectory();
    var path = '${tempDirectory.path}/flutter_sound';
    if (!isRecorderInit) {
      return;
    }
    if (isRecording) {
      await _soundRecorder!.stopRecorder();
      //  sendAudioFile(File(path));
      File file = File(path);
      List<int> imageBytes = file.readAsBytesSync();
      String base64Audio = base64Encode(imageBytes);
      audioText = base64Audio;
      // Get.log("Audio text is $audioText");
      //speechToText.stop();
      sendMessageAPi();
      //Get.log("Uploading now ");
      await uploadAudio(recordFile: path).then((value) {
        // services.sendNotification(
        //     name: chatScreenController.loggedInUserName!,
        //     token: widget.fcmToken);
      });
    } else {
      await _soundRecorder!.startRecorder(
        toFile: path,
      );
      recorderSubscription = _soundRecorder!.onProgress!.listen((e) {
        debugPrint(e.toString());
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
        setState(() {
          _timerText = timeText.substring(0, 8);
          debugPrint(_timerText);
        });
      });
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  int i = 0;

  /// Uploading Audio to fireStore
  Future uploadAudio({required String recordFile}) async {
    // UploadTask uploadTask = Get.find<ChatScreenController>().uploadAudio(
    //     File(recordFile),
    //     "audio/${DateTime.now().millisecondsSinceEpoch.toString()}");
    // try {
    // TaskSnapshot snapshot = await uploadTask;
    // audioURL = await snapshot.ref.getDownloadURL();
    // String strVal = audioURL.toString();
    // audioController.isSending.value = false;
    // Get.log("Total Duration is ${audioController.total}");
    // sendButton(
    //     type: MessageType.audio,
    //     duration: audioController.total,
    //     mesContent: strVal);
    // services.sendNotification(
    //     name: chatScreenController.loggedInUserName!,
    //     token: widget.fcmToken);
    // } on FirebaseException {
    //   setState(() {
    //     audioController.isSending.value = false;
    //   });
    // }
  }

  Widget audio({
    required String message,
    required bool isCurrentUser,
    required int index,
    required String time,
    required String duration,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 35,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: isCurrentUser ? const Color(0xFFFFD54B) : Colors.black,
            border: const BorderDirectional(
                bottom: BorderSide(color: Colors.white, width: 1)),
            boxShadow: [
              BoxShadow(
                color: isCurrentUser ? Colors.white : Constants.primaryColor,
                offset: const Offset(0, 1.5),
                spreadRadius: 1.5,
                blurRadius: 1.5,
              )
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                audioController.onPressedPlayButton(index, message);
              },
              onSecondaryTap: () {
                audioPlayer.stop();
              },
              child: Obx(
                () => (audioController.isRecordPlaying &&
                        audioController.currentId == index)
                    ? Icon(
                        Icons.stop,
                        color: isCurrentUser
                            ? Colors.black
                            : Constants.primaryColor,
                      )
                    : Icon(
                        Icons.play_arrow,
                        color: isCurrentUser
                            ? Colors.black
                            : Constants.primaryColor,
                      ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                      LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor:
                            const Color.fromARGB(255, 209, 209, 209),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrentUser ? Colors.black : Constants.primaryColor,
                        ),
                        value: (audioController.isRecordPlaying &&
                                audioController.currentId == index)
                            ? audioController.completedPercentage.value
                            : audioController.totalDuration.value.toDouble(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              duration,
              style: TextStyle(
                fontSize: 12,
                color: isCurrentUser ? Colors.black : Constants.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        backgroundColor: Constants.secondaryColor,
        title: GestureDetector(
          onTap: () {
            // Get.to(() => SellerProfileScreen(
            //       sellerID: widget.sellerID,
            //     ));
          },
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                // color: Colors.amber,
                child: GestureDetector(
                  onTap: () {
                    // debugPrint(ctr.profileData.value.list?.imageURL);
                    // Get.to(() => UploadImageScreen(
                    //     userId: widget.userId.toString()));
                  },
                  child: Container(
                    // height: 50,
                    // width: 50,
                    // decoration: BoxDecoration(

                    // ),
                    child: widget.profileImage == ""
                        ? Center(
                            child: Opacity(
                            opacity: 0.7,
                            child: Icon(
                              Icons.camera_alt,
                              color: R.colors.white.withOpacity(0.7),
                              size: 35,
                            ),
                          ))
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                color: R.colors.lightGrey,
                                border: const BorderDirectional(
                                    bottom: BorderSide(color: Colors.white)),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            imageUrl: widget.profileImage,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: R.colors.themeColor,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                widget.name,
                style: GoogleFonts.antic(
                    color: Color(0xFFC4C4C4),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(0.0),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF333333), Color(0xFF747474)])),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 13,
                )),
          ),
        ),
        actions: [
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     width: 50,
          //     margin: const EdgeInsets.all(2),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       // border: Border.all(color: Colors.white),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Container(
          //           height: 30,
          //           width: 30,
          //           margin: const EdgeInsets.all(2),
          //           decoration: BoxDecoration(
          //             color: Colors.black,
          //             borderRadius: const BorderRadius.only(
          //               topLeft: Radius.circular(5),
          //               bottomLeft: Radius.circular(0),
          //               topRight: Radius.circular(5),
          //               bottomRight: Radius.circular(5),
          //             ),
          //             image: DecorationImage(
          //                 image: NetworkImage(
          //                   widget.queryImage,
          //                 ),
          //                 fit: BoxFit.cover),
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 1,
          //                   offset: const Offset(0, 2),
          //                   spreadRadius: 0.6,
          //                   color: Colors.white.withOpacity(0.4))
          //             ],
          //           ),
          //         ),
          //         Text(
          //           "Quote Detail",
          //           style: GoogleFonts.antic(
          //               color: const Color(0xFFC4C4C4),
          //               fontWeight: FontWeight.w600,
          //               fontSize: 8),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () async {
              final queryController =
                  Provider.of<QueryController>(context, listen: false);
              Utils.showLoadingDialog(context);
              await queryController
                  .getQueryComparisonList(widget.rate.mindata.queryID);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CompareScreen();
              }));
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black,
                // border: Border.all(color: Colors.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/newImages/f5a2d817cf1c6f706a49ce724df04ae7.png",
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Text(
                    "Compare",
                    style: GoogleFonts.antic(
                        color: const Color(0xFFC4C4C4),
                        fontWeight: FontWeight.w600,
                        fontSize: 8),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 50,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              // border: Border.all(color: Colors.white),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          "assets/newImages/d389bc9eb79dcd9deb5478e2e2be3db4.png",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Text(
                  "Rs. ${widget.rate.minrate}",
                  style: GoogleFonts.antic(
                      color: Color(0xFFC4C4C4),
                      fontWeight: FontWeight.w600,
                      fontSize: 8),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              buildListMessage(),
              widget.isActive ? chatFieldBottom() : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  Widget modules() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (showImage == false)
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          // decoration: BoxDecoration(
                          //   color: R.colors.white,
                          //   borderRadius: const BorderRadius.only(
                          //     topLeft: Radius.circular(10),
                          //     topRight: Radius.circular(10),
                          //   ),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  pickImage('camera');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: R.colors.black,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('Camera'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Divider(
                                color: R.colors.lightGrey,
                                thickness: 1,
                                height: 1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  pickImage('gallery');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      color: R.colors.black,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('Gallery'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.camera_alt,
                        color: R.colors.themeColor,
                      ),
                    ),
                  ),
                ),
              if (showImage == false)
                const SizedBox(
                  width: 10,
                ),
              if (showImage == false)
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          // decoration: BoxDecoration(
                          //   color: R.colors.white,
                          //   borderRadius: const BorderRadius.only(
                          //     topLeft: Radius.circular(10),
                          //     topRight: Radius.circular(10),
                          //   ),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  await pickVideo('camera');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: R.colors.black,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('Camera'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Divider(
                                color: R.colors.lightGrey,
                                thickness: 1,
                                height: 1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  await pickVideo('gallery');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      color: R.colors.black,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text('Gallery'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Icon(
                          Icons.video_camera_back_outlined,
                          color: R.colors.themeColor,
                        )),
                  ),
                ),
              if (showImage == false)
                const SizedBox(
                  width: 10,
                ),
              if (showImage == false)
                GestureDetector(
                  onTap: () async {
                    await recordSoundApi();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: isRecording == true
                          ? Icon(
                              Icons.stop,
                              color: R.colors.themeColor,
                            )
                          : Icon(
                              Icons.mic,
                              color: R.colors.themeColor,
                            ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  // final _key = GlobalKey<ExpandableFabState>();
  Widget chatFieldBottom() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      //height: 50,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: const Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Constants.primaryColor),
      child: Row(
        children: [
          // ExpandableFab(
          //   key: _key,
          //   type: ExpandableFabType.up,
          //   childrenAnimation: ExpandableFabAnimation.none,
          //   distance: 70,
          //   overlayStyle: ExpandableFabOverlayStyle(
          //     color: Colors.white.withOpacity(0.9),
          //   ),
          //   children: const [
          //     Row(
          //       children: [
          //         Text('Remind'),
          //         SizedBox(width: 20),
          //         FloatingActionButton.small(
          //           heroTag: null,
          //           onPressed: null,
          //           child: Icon(Icons.notifications),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Text('Email'),
          //         SizedBox(width: 20),
          //         FloatingActionButton.small(
          //           heroTag: null,
          //           onPressed: null,
          //           child: Icon(Icons.email),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Text('Star'),
          //         SizedBox(width: 20),
          //         FloatingActionButton.small(
          //           heroTag: null,
          //           onPressed: null,
          //           child: Icon(Icons.star),
          //         ),
          //       ],
          //     ),
          //     FloatingActionButton.small(
          //       heroTag: null,
          //       onPressed: null,
          //       child: Icon(Icons.add),
          //     ),
          //   ],
          // ),
          if (showImage == false)
            GestureDetector(
              onTap: () {
                isOpened = !isOpened;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(0),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(12),
                //   color: const Color(0xfff9f9f9),
                //   boxShadow: const [
                //     BoxShadow(
                //       color: Colors.grey,
                //       offset: Offset(2, 2),
                //       spreadRadius: 2,
                //       blurRadius: 2,
                //     )
                //   ],
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(
                    isOpened ? Icons.close : Icons.attach_file,
                    color: R.colors.themeColor,
                  ),
                ),
              ),
            ),
          const SizedBox(
            width: 10,
          ),
          isOpened
              ? Expanded(child: modules())
              : Expanded(
                  child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                      )),
                  child: TextField(
                    controller: message,
                    maxLines: null,
                    style: GoogleFonts.antic(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      // border: InputBorder.none,
                      hintText: 'Write your message here',
                      hintStyle: GoogleFonts.antic(
                          color: const Color(0xFF878787), fontSize: 13),
                      // fillColor: Constants.secondaryColor,
                      // suffix: IconButton(
                      //   onPressed: () {
                      //     message.clear();
                      //   },
                      //   icon: const Icon(
                      //     Icons.copy,
                      //     color: Color(0xFF797C7B),
                      //   ),
                      // ),
                      border: const OutlineInputBorder(
                          // borderSide: BorderSide(
                          //     color: Constants.primaryColor,
                          //     width: 1,
                          //     strokeAlign: 0.5),
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                      )),
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                )),
          if (showImage == false)
            const SizedBox(
              width: 10,
            ),
          const SizedBox(
            width: 10,
          ),
          isOpened
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () async {
                    await sendMessageAPi();
                    // sendButton(
                    //     mesContent: message.text, type: MessageType.text);
                    if (message.text.isNotEmpty) {
                      // services.sendNotification(
                      //     name: chatScreenController.loggedInUserName!,
                      //     token: widget.fcmToken);
                    }
                    message.clear();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(0),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(12),
                    //   color: const Color(0xfff9f9f9),
                    //   boxShadow: const [
                    //     BoxShadow(
                    //       color: Colors.grey,
                    //       offset: Offset(2, 2),
                    //       spreadRadius: 2,
                    //       blurRadius: 2,
                    //     )
                    //   ],
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.send_rounded,
                        color: R.colors.themeColor,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget buildListMessage() {
    String lastDate = "";
    return Flexible(
      child: widget.groupId.isNotEmpty
          ? StreamBuilder(
              stream: Get.find<ChatController>().getQueryChat(widget.groupId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Get.find<ChatScreenController>()
                  //     .updateMessageReadStatus(widget.groupId, widget.userMap);
                  Get.find<ChatScreenController>().messagesList =
                      snapshot.data!.reversed.toList();
                  if (Get.find<ChatScreenController>()
                      .messagesList
                      .isNotEmpty) {
                    return ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final message = Get.find<ChatScreenController>()
                            .messagesList[index];
                        final messageDate = DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(message.chatDateTime!));

                        bool showDateHeader = lastDate != messageDate;
                        lastDate = messageDate;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          // shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            if (showDateHeader && index >= 0)
                              Container(
                                height: 50,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        DateFormat('dd MMM yyyy').format(
                                            DateTime.parse(
                                                message.chatDateTime!)),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            buildItem(index, message),
                          ],
                        );
                      },
                      // (context, index) =>
                      // buildItem(index,
                      //     Get.find<ChatScreenController>().messagesList[index]),
                      itemCount:
                          Get.find<ChatScreenController>().messagesList.length,
                      //controller: listScrollController,
                    );
                  } else {
                    return const Center(child: Text("No message here yet..."));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Constants.primaryColor,
                    ),
                  );
                }
              })
          : Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            ),
    );
  }

  Widget buildItem(int index, GetChatModelList messageModel) {
    if (messageModel.chatType!.toLowerCase() == 'buyer') {
      // Right (my message)
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          messageModel.messageType!.toLowerCase() ==
                  MessageType.text.toLowerCase()
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          // onLongPress: () {
                          //   DialogueBox().deleteMessage(context, () {
                          //     Get.find<ChatController>()
                          //         .deleteSingleMessage(
                          //         groupId: widget.groupId,
                          //         messageId: messageModel.messageId);
                          //     Get.back();
                          //   });
                          //
                          //   Get.log("Text Message is Pressed$index");
                          // },
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 200, minHeight: 25, minWidth: 60),
                            decoration: BoxDecoration(
                                color: const Color(0xFF050505),
                                border: const BorderDirectional(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 1)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Constants.primaryColor,
                                    offset: const Offset(0, 1.5),
                                    spreadRadius: 1.5,
                                    blurRadius: 1.5,
                                  )
                                ],
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                messageModel.message!,
                                style: TextStyle(
                                    fontFamily: GoogleFonts.antic().fontFamily,
                                    color: Constants.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          getFormattedTime(
                              context: context,
                              time: messageModel.chatDateTime!),
                          style: const TextStyle(
                              fontSize: 10, color: Color(0xFF797C7B)
                              // color: R.colors.white.withOpacity(0.8)
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : messageModel.messageType?.toLowerCase() == MessageType.image
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullImageView(
                                          images: [
                                            messageModel.docURL.toString()
                                          ],
                                          initialIndex: 0,
                                          isMemoryImage: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 200,
                                          minHeight: 200,
                                          maxHeight: 200,
                                          minWidth: 200),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF050505),
                                          border: const BorderDirectional(
                                              bottom: BorderSide(
                                                  color: Colors.white,
                                                  width: 1)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Constants.primaryColor,
                                              offset: const Offset(0, 1.5),
                                              spreadRadius: 1.5,
                                              blurRadius: 1.5,
                                            )
                                          ],
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(messageModel
                                                  .docURL
                                                  .toString()),
                                              fit: BoxFit.cover)),
                                      child: messageModel.docURL == ""
                                          ? Center(
                                              child: CircularProgressIndicator(
                                              color: Constants.primaryColor,
                                            ))
                                          : null)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            getFormattedTime(
                                context: context,
                                time: messageModel.chatDateTime!),
                            style: const TextStyle(
                                fontSize: 10, color: Color(0xFF797C7B)
                                // color: R.colors.white.withOpacity(0.8)
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : messageModel.messageType?.toLowerCase() ==
                          MessageType.video.toLowerCase()
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        await Utils.showVideoDialog(
                                            context,
                                            messageModel.docURL.toString(),
                                            true);
                                      },
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 200,
                                              minHeight: 200,
                                              maxHeight: 200,
                                              minWidth: 200),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF050505),
                                              border: const BorderDirectional(
                                                  bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Constants.primaryColor,
                                                  offset: const Offset(0, 1.5),
                                                  spreadRadius: 1.5,
                                                  blurRadius: 1.5,
                                                )
                                              ],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      messageModel.docURL
                                                          .toString()),
                                                  fit: BoxFit.cover)),
                                          child: messageModel.docURL == ""
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: Constants.primaryColor,
                                                ))
                                              : const Center(
                                                  child: Icon(
                                                    Icons.play_circle,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                getFormattedTime(
                                    context: context,
                                    time: messageModel.chatDateTime!),
                                style: const TextStyle(
                                    fontSize: 10, color: Color(0xFF797C7B)
                                    // color: R.colors.white.withOpacity(0.8)
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : messageModel.messageType?.toLowerCase() ==
                              MessageType.audio
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                audio(
                                    message: messageModel.message!,
                                    isCurrentUser:
                                        messageModel.chatType!.toLowerCase() ==
                                            'seller',
                                    index: index,
                                    time: messageModel.chatDateTimeString!
                                        .toString(),
                                    duration: "0"),
                                // messageModel.duration.toString()),
                                const SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    getFormattedTime(
                                        context: context,
                                        time: messageModel.chatDateTime!),
                                    style: const TextStyle(
                                        fontSize: 10, color: Color(0xFF797C7B)
                                        // color: R.colors.white.withOpacity(0.8)
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : CircularProgressIndicator(
                              color: R.colors.themeColor,
                            )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          messageModel.messageType?.toLowerCase() == MessageType.text
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: 200, minHeight: 25, minWidth: 60),
                          //width: getWidth(200),
                          decoration: const BoxDecoration(
                              color: Color(0xFFFFD54B),
                              border: BorderDirectional(
                                  bottom: BorderSide(
                                      color: Colors.white, width: 1)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0, 1.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                          // decoration: BoxDecoration(
                          //     color: R.colors.grey,
                          //     borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 3.0),
                            child: Text(
                              messageModel.message!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          getFormattedTime(
                              context: context,
                              time: messageModel.chatDateTime!),
                          style: const TextStyle(
                              fontSize: 10, color: Color(0xFF797C7B)
                              // color: R.colors.white.withOpacity(0.8)
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : messageModel.messageType?.toLowerCase() == MessageType.image
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullImageView(
                                    images: [messageModel.docURL.toString()],
                                    initialIndex: 0,
                                    isMemoryImage: false,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 200,
                                    maxWidth: 200,
                                    minHeight: 200,
                                    minWidth: 200),
                                //width: getWidth(200),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFD54B),
                                    border: const BorderDirectional(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 1)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0, 1.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                      )
                                    ],
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            messageModel.docURL.toString()),
                                        fit: BoxFit.cover)),
                                child: messageModel.docURL == ""
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: Constants.primaryColor,
                                      ))
                                    : null),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            decoration: const BoxDecoration(
                                // color: Colors.grey.withOpacity(0.8)
                                ),
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              getFormattedTime(
                                  context: context,
                                  time: messageModel.chatDateTime!),
                              // ' ${(DateTime.fromMillisecondsSinceEpoch(int.parse(messageModel.timestamp)).hour.toString())}:'
                              // '${(DateTime.fromMillisecondsSinceEpoch(int.parse(messageModel.timestamp)).minute.toString())}',
                              style: const TextStyle(
                                  fontSize: 10, color: Color(0xFF797C7B)
                                  // color: R.colors.white.withOpacity(0.8)
                                  ),
                            ),
                          ),
                        )
                        //:SizedBox(height: getHeight(200),width: getWidth(200),
                        //child: const Center(child: CircularProgressIndicator(color: MyColors.primaryColor,),),),
                      ],
                    )
                  : messageModel.messageType?.toLowerCase() == MessageType.video
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await Utils.showVideoDialog(context,
                                      messageModel.docURL.toString(), true);
                                },
                                child: Container(
                                    constraints: const BoxConstraints(
                                        maxHeight: 200,
                                        maxWidth: 200,
                                        minHeight: 200,
                                        minWidth: 200),
                                    //width: getWidth(200),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFFFD54B),
                                        border: const BorderDirectional(
                                            bottom: BorderSide(
                                                color: Colors.white, width: 1)),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0, 1.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                          )
                                        ],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                messageModel.docURL.toString()),
                                            fit: BoxFit.cover)),
                                    child: messageModel.docURL == ""
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: Constants.primaryColor,
                                          ))
                                        : const Center(
                                            child: Icon(
                                              Icons.play_circle,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          )),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                getFormattedTime(
                                    context: context,
                                    time: messageModel.chatDateTime!),
                                style: const TextStyle(
                                    fontSize: 10, color: Color(0xFF797C7B)
                                    // color: R.colors.white.withOpacity(0.8)
                                    ),
                              ),
                            ),
                          ],
                        )
                      : messageModel.messageType?.toLowerCase() ==
                              MessageType.audio
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                audio(
                                    message: messageModel.message!,
                                    isCurrentUser:
                                        messageModel.chatType!.toLowerCase() ==
                                            'seller',
                                    index: index,
                                    time: messageModel.chatDateTimeString
                                        .toString(),
                                    duration: "0"),
                                // messageModel.duration.toString()),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  decoration: const BoxDecoration(),
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    getFormattedTime(
                                        context: context,
                                        time: messageModel.chatDateTime!),
                                    style: const TextStyle(
                                        fontSize: 10, color: Color(0xFF797C7B)
                                        // color: R.colors.white.withOpacity(0.8)
                                        ),
                                  ),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(
                              color: R.colors.themeColor,
                            )
        ],
      );
    }
  }
}
