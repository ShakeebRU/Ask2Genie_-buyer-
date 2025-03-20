import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String currentID;
  String timestamp;
  String messageId;
  String messageContent;
  String? duration;
  //String? fileName;
  String type;

  MessageModel({
    required this.currentID,
    required this.timestamp,
    required this.messageContent,
    required this.messageId,
    this.duration,
    //required this.userStatus,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "sender": currentID,
      "timeStamp": timestamp,
      "duration": duration,
      "messageId": messageId,
      "message": messageContent,
      "messageType": type,
    };
  }

  factory MessageModel.fromJson(DocumentSnapshot doc) {
    String currentID = doc.get("sender");
    String messageContent = doc.get("message");
    String timestamp = doc.get("timeStamp") ?? DateTime.now();
    String messageId = doc.get("messageId");
    String duration = doc.get("duration");
    String type = doc.get("messageType");
    return MessageModel(
        messageId: messageId,
        type: type,
        duration: duration,
        currentID: currentID,
        messageContent: messageContent,
        timestamp: timestamp);
  }
}
