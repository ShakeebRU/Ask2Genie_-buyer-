// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../models/message_model.dart';
import '../../models/query/query_chat_model.dart';

class ChatScreenController extends GetxController {
  List<GetChatModelList> messagesList = [];
  // final storage = FirebaseStorage.instance;
  // final fireStore = FirebaseFirestore.instance;
  // final auth = FirebaseAuth.instance;
  String? loggedInUserName;
  currentUserData() async {
    // await fireStore
    //     .collection('users')
    //     .doc(auth.currentUser!.uid.toString())
    //     .get()
    //     .then((value) {
    //   loggedInUserName = value.data()!['name'];
    //   Get.log("Current user name is $loggedInUserName");
    // });
  }

  // message(
  //     {required String groupID,
  //     required String type,
  //     required String senderId,
  //     required String messageContent,
  //     required String messageId,
  //     required String timeStamp,
  //     String duration = ""}) {
  // fireStore
  //     .collection('chatRoom')
  //     .doc(groupID)
  //     .collection('message')
  //     .doc(messageId)
  //     .set({
  //   'message': messageContent,
  //   'sender': senderId,
  //   'timeStamp': timeStamp,
  //   'messageId': messageId,
  //   'messageType': type,
  //   'duration': duration
  // });
  //   MessageModel messageModel = MessageModel(
  //     type: type,
  //     messageContent: messageContent,
  //     timestamp: timeStamp,
  //     messageId: messageId,
  //     currentID: senderId,
  //     // receiverID: receiverId,
  //     //receiverFName: receiverFName,
  //     //receiverLName: receiverLName,
  //     //userStatus: userStatus,
  //     duration: duration,
  //     //readStatus: readStatus
  //   );
  // }

  // Stream<QuerySnapshot<Object?>?>? getAllMessages(String groupChatId) {
  //   return FirebaseFirestore.instance
  //       .collection('chatRoom')
  //       .doc(groupChatId)
  //       .collection('message')
  //       .orderBy('timeStamp')
  //       //.limit(10)
  //       .snapshots();
  //   // return collectionSnapshot.docs.isNotEmpty;
  //   //  fireStore.collection("chatRoom").limit(1).get().then((value) {
  //   //    print("value   ${value.size}");
  //   //    if (value.docs.isNotEmpty) {
  //   //      return fireStore
  //   //          .collection('chatRoom')
  //   //          .doc(groupID)
  //   //          .collection('ChatUsers')
  //   //          .doc(auth.currentUser!.uid)
  //   //          .collection('message')
  //   //          .orderBy('timeStamp')
  //   //          .snapshots();
  //   //      return value;
  //   //    } else {
  //   //      print("no sRT");
  //   //      return const Center(
  //   //        child: Text('No Messages Here yet...............'),
  //   //      );
  //   //    }
  //   //  });
  //   //  // if(data.) {
  //   //  //   print("no sRT");
  //   //  //  return null;
  //   //  // }
  //   //  //   else{
  //   //  //   return data;
  //   //  // }
  //   //  ;
  // }

  // UploadTask uploadAudio(var audioFile, String fileName) {
  //   Reference reference = storage.ref().child(fileName);
  //   UploadTask uploadTask = reference.putFile(audioFile);
  //   return uploadTask;
  // }

  @override
  void onInit() {
    currentUserData();
    // TODO: implement onInit
    super.onInit();
  }
}

class MessageType {
  static const text = "text";
  static const image = "image";
  static const audio = "audio";
  static const video = "video";
}
