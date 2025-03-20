import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../constants/apilinks.dart';
import '../../models/auth/register_response_model.dart';
import '../../models/query/buyer_notification_list_model.dart';
import '../../models/query/query_chat_model.dart';
import '../../models/query/query_min_rate_model.dart';
import '../../resources/resources.dart';
import '../../services/dio_client.dart';
import 'chat_screen_controller.dart';

class ChatController extends GetxController {
  Dio dio = Dio();
  String image = '';
  Rx<GetChatModel> chatdata = GetChatModel().obs;

  Future sendMessage(
      {required int qsID,
      required String chatType,
      required int sellerID,
      required String messageType,
      required String msg,
      String? base64File}) async {
    // openLoader();
    Dio dio = Dio();
    dio.options.connectTimeout = (const Duration(seconds: 10));
    bool val = false;

    image = '';
    debugPrint(base64File);
    print("object12: $messageType");
    // print(category.toString());
    var request = {
      "qsComputerNo": qsID,
      "chatType": chatType,
      "messageType": messageType,
      "message": msg,
    };

    debugPrint("This is my request====================$request");
    debugPrint(ApiLinks.sellerQueryChatInsert);
    var response = await DioClient()
        .post(ApiLinks.sellerQueryChatInsert, request)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = RegisterResponseModel.fromJson(response.data);
      if (data.status == true) {
        debugPrint(data.toString());
        var id = int.parse(data.returnId!);
        // String? img = base64File;
        if (messageType.toLowerCase() == MessageType.image ||
            messageType.toLowerCase() == MessageType.audio) {
          insertFile(id: id, base64File: base64File!, type: messageType);
        }
        if (messageType.toLowerCase() == MessageType.video) {
          await chatVedioUpload(base64File!, id.toString());
        }
        // await sendTopicMessage("seller${sellerID}",
        //     await GetStorage().read("name"), "New messege");
        // Get.back();
        // Get.back();
        // Get.back();
        // Get.snackbar(
        //   'Success',
        //   data.returnMessage.toString(),
        //   snackPosition: SnackPosition.TOP,
        //   // backgroundColor: R.colors.themeColor,
        // );
        // getNewQuery(sID);
        // // await GetStorage().write("regId", data.returnId);
        // // Get.off(() => UploadImageScreen(userId: data.returnId!) );
        // // Get.back();
      } else {
        // Get.back();
        Get.snackbar('Error', data.returnMessage.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
            colorText: R.colors.white);
      }
    }

    return val;
  }

  Future<void> chatVedioUpload(String videoBase64, String chatid) async {
    try {
      // Prepare the request
      final uri = Uri.parse("${ApiLinks.chatinsertvideo}?chatid=$chatid");
      final request = http.MultipartRequest('POST', uri);
      var token = await GetStorage().read('token');
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        base64Decode(videoBase64),
        filename: DateTime.now().microsecondsSinceEpoch.toString(),
      ));
      final response = await request.send();
      if (response.statusCode == 200) {
        print("Video uploaded successfully.");
        final responseBody = await response.stream.bytesToString();
        print(responseBody);
      } else {
        print("Failed to upload video. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading video: $e");
    }
  }

  Future insertFile(
      {required int id,
      required String base64File,
      required String type}) async {
    // openLoader();

    // print(category.toString());
    var request = {"computerNo": id, "imageBase64": base64File, "type": type};

    debugPrint("This is my file====================$request");
    debugPrint(ApiLinks.insertChatImage);

    var response = await DioClient()
        .post(ApiLinks.insertChatImage, request)
        .catchError((error) {
      debugPrint(error.toString());
    });

    if (response == null) return;
    debugPrint(
        "This is my file response==================${response.statusCode}");
    debugPrint("This is my file response==================${response.data}");
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = RegisterResponseModel.fromJson(response.data);

      if (data.status == true) {
        debugPrint(data.toString());
      } else {
        // Get.back();
        Get.snackbar(
          'Error',
          data.returnMessage.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
      }
    }

    return null;
  }

  Future<void> sendTopicMessage(String topic, String title, String body) async {
    // final String topic = 'flag'; // Replace with the topic name
    final Map<String, dynamic> message = {
      // "to": "/topics/$topic",
      "to": "/topics/$topic",
      'notification': {
        'title': title,
        'body': body,
      },
    };

    const String url = 'https://fcm.googleapis.com/fcm/send';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAg93ux7o:APA91bELXVWecuKKRUnRUmx53Yz_pcuL07EMxigsobiQPE_t-iq5la3bJoGLJnFiVEbb7_8Om5d1VIuQdtBVZWHKopHA4cP-S2jlZyQj79E3O0i78gf9gmVV4dKF4C1wjQ3d3bdANt71',
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(message),
    );

    if (response.statusCode == 200) {
      print('Topic message sent successfully.');
    } else {
      print(
          'Failed to send topic message. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Stream<List<GetChatModelList>> getQueryChat(String qsNumber) async* {
    while (true) {
      dio.options.connectTimeout = (const Duration(seconds: 10));
      debugPrint("${ApiLinks.getQueryChat}?QSComputerNo=$qsNumber");
      var response = await DioClient()
          .get("${ApiLinks.getQueryChat}?QSComputerNo=$qsNumber")
          .catchError((error) {
        debugPrint(error.toString());
      });
      if (response != null) {
        debugPrint("This is my response==================${response.data}");
        debugPrint(response.statusCode.toString());
        if (response.statusCode == 200) {
          var data = GetChatModel.fromJson(response.data);
          chatdata.value = data;
          update();
          print("Chat Lenght : ${data.list!.length}");
          yield data.list ?? [];
        } else {
          yield [];
        }
      } else {
        yield [];
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  // getQueryMinRateList
  QueryMinRateModel? queryMinRateList;
  Future<QueryMinRateModel?> getQueryMinRateList(int id) async {
    queryMinRateList = null;
    debugPrint("here");
    debugPrint("${ApiLinks.getqueryminratelist}?queryid=$id");
    var response = await DioClient()
        .get("${ApiLinks.getqueryminratelist}?queryid=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      QueryMinRateModel data = QueryMinRateModel.fromJson(response.data);
      queryMinRateList = data;
      update();
      return queryMinRateList;
    }
    return null;
  }

  // getQueryComparisonList
  List<NotificationModel> queryComparisonList = [];
  Future<List<NotificationModel>?> getQueryComparisonList(int id) async {
    queryComparisonList = [];
    debugPrint("here");
    debugPrint("${ApiLinks.getquerycomparisonlist}?queryid=$id");
    var response = await DioClient()
        .get("${ApiLinks.getquerycomparisonlist}?queryid=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      BuyerNotificationModelsListModel data =
          BuyerNotificationModelsListModel.fromJson(response.data);
      queryComparisonList = data.list;
      update();
      return queryComparisonList;
    }
    return null;
  }
}
