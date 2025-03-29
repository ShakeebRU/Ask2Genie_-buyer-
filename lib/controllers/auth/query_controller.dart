import 'dart:convert';
import 'package:genie/models/best_sellers_list_mdel.dart';
import 'package:genie/models/query/seller_query_reponse_mode.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/apilinks.dart';
import '../../models/auth/register_response_model.dart';
import '../../models/query/active_query_model.dart';
import '../../models/query/active_query_sellers_model.dart';
import '../../models/query/buyer_notification_list_model.dart';
import '../../models/query/query_details_model.dart';
import '../../models/query/query_image_model.dart';
import '../../models/query/query_model.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class QueryController extends ChangeNotifier {
  Future addNewQuery(BuildContext context,
      {required int buyerID,
      required int catID,
      required String catName,
      required int isNewChecked,
      required int isUsedChecked,
      required int isAlternateCheck,
      required String name,
      required String brand,
      required String req,
      required String dueDateTime,
      required List<String> uploadImages,
      required int qty,
      String uploadVedio = "",
      String uploadAudio = ""}) async {
    var request = {
      "qty": qty,
      "conditionNew": isNewChecked,
      "conditionUsed": isUsedChecked,
      "alternateProduct": isAlternateCheck,
      "dueDateTime": "${dueDateTime.replaceFirst(" ", "T")}Z",
      "dueDateTimeString": "${dueDateTime.replaceFirst(" ", "T")}Z",
      "productName": name,
      "productDescription": req,
      "queryDateTimeString":
          "${DateTime.now().toString().replaceFirst(" ", "T")}Z",
      "categoryName": catName,
      "buyerID": buyerID,
      "categoryID": catID,
      "requirementsDetail": req,
      "brandModel": brand,
    };
    debugPrint("This is my request====================$request");
    var response = await DioClient()
        .post(ApiLinks.queryInsert, request)
        .catchError((error) {
      Get.back();
      debugPrint(error.toString());

      if (error is BadRequestException) {
        Get.snackbar(
          'Error',
          error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
          colorText: R.colors.white,
        );
      } else {
        debugPrint(error.toString());
      }
    });

    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      var data = RegisterResponseModel.fromJson(response.data);
      if (data.status == true) {
        var id = data.returnId ?? "";
        for (var i = 0; i < uploadImages.length; i++) {
          await queryImageUpload(
              comID: int.parse(id), img: uploadImages[i], subID: (i + 1));
        }
        if (uploadVedio.isNotEmpty) {
          await queryVedioUpload(uploadVedio, id);
        }
        if (uploadAudio.isNotEmpty) {
          await queryAudioUpload(
              comID: int.parse(id), audio: uploadAudio, subID: 0);
        }
        // await sendTopicMessage(catName, catName, "New Query added");
        Navigator.pop(context);
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Success",
            message: data.returnMessage.toString(),
            backgroundColor: Constants.textColor);
        notifyListeners();
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: data.returnMessage.toString(),
            backgroundColor: Constants.textColor);
      }
    }
  }

  // Future<void> sendTopicMessage(String topic, String title, String body) async {
  //   final Map<String, dynamic> message = {
  //     "to": "/topics/$topic",
  //     'notification': {
  //       'title': title,
  //       'body': body,
  //     },
  //   };

  //   const String url = 'https://fcm.googleapis.com/fcm/send';
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization':
  //         'key=AAAAg93ux7o:APA91bELXVWecuKKRUnRUmx53Yz_pcuL07EMxigsobiQPE_t-iq5la3bJoGLJnFiVEbb7_8Om5d1VIuQdtBVZWHKopHA4cP-S2jlZyQj79E3O0i78gf9gmVV4dKF4C1wjQ3d3bdANt71',
  //   };

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: headers,
  //     body: json.encode(message),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Topic message sent successfully.');
  //   } else {
  //     print(
  //         'Failed to send topic message. Status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }

  Future queryImageUpload(
      {required int comID, required String img, required int subID}) async {
    var request = {"computerNo": comID, "imageBase64": img, "subID": subID};
    debugPrint("This is my request====================$request");
    var response = await DioClient()
        .post(ApiLinks.imageInsert, request)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
  }

  // Future queryVedioUpload(
  //     {required int comID, required String img, required int subID}) async {
  //   var request = {"computerNo": comID, "imageBase64": img, "subID": subID};
  //   debugPrint("This is my request====================$request");
  //   var response = await DioClient()
  //       .post(ApiLinks.imageInsert, request)
  //       .catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //   if (response == null) return;
  //   debugPrint("This is my response==================${response.statusCode}");
  //   debugPrint("This is my response==================${response.data}");
  // }
  Future<void> queryVedioUpload(String videoBase64, String queryID) async {
    try {
      // Prepare the request
      final uri = Uri.parse("${ApiLinks.queryinsertvideo}?queryid=$queryID");
      final request = http.MultipartRequest('POST', uri);
      var token = await GetStorage().read('token');
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      // Add the video as a file (decoded back from base64)
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        base64Decode(videoBase64),
        filename: DateTime.now().microsecondsSinceEpoch.toString(),
      ));

      // Send the request
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

  Future queryAudioUpload(
      {required int comID, required String audio, required int subID}) async {
    var request = {"computerNo": comID, "imageBase64": audio, "subID": subID};
    debugPrint("This is my request====================$request");
    var response = await DioClient()
        .post(ApiLinks.queryinsertaudio, request)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
  }

  // active Queries Controller
  List<QueryModel> activeQueries = [];
  Future<List<QueryModel>?> getActiveQueryList(int id) async {
    activeQueries = [];
    debugPrint("here");
    debugPrint("${ApiLinks.getBuyerActiveQuery}?BuyerID=$id");
    var response = await DioClient()
        .get("${ApiLinks.getBuyerActiveQuery}?BuyerID=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      ActiveQueryResponseModel data =
          ActiveQueryResponseModel.fromJson(response.data);
      activeQueries = data.list!;
      notifyListeners();
      return data.list;
    }
    return null;
  }

  List<NotificationModel> notificationsList = [];
  Future<List<NotificationModel>?> getNotificationsList(int id) async {
    notificationsList = [];
    debugPrint("here");
    debugPrint("${ApiLinks.getactivequerysellerlist}?BuyerID=$id");
    var response = await DioClient()
        .get("${ApiLinks.getactivequerysellerlist}?BuyerID=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });

    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      BuyerNotificationModelsListModel data =
          BuyerNotificationModelsListModel.fromJson(response.data);
      notificationsList = data.list;
      notifyListeners();
      return notificationsList;
    }
    return null;
  }

  QuotationDataModel? quotation;
  Future<QuotationDataModel?> getSelleryQueryResponse(int id) async {
    quotation = null;
    debugPrint("here");
    debugPrint("${ApiLinks.getselleryqueryresponse}?qscomputerno=$id");
    var response = await DioClient()
        .get("${ApiLinks.getselleryqueryresponse}?qscomputerno=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });

    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      SellerQueryResponseModel data =
          SellerQueryResponseModel.fromJson(response.data);
      quotation = data.list;
      notifyListeners();
      return quotation;
    }
    return null;
  }

  List<NotificationModel> selectedSellers = [];
  Future<List<NotificationModel>?> getselectedSellersList(int id) async {
    selectedSellers = [];
    debugPrint("here");
    debugPrint("${ApiLinks.getselectedquerysellerlist}?buyerid=$id");
    var response = await DioClient()
        .get("${ApiLinks.getselectedquerysellerlist}?buyerid=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      BuyerNotificationModelsListModel data =
          BuyerNotificationModelsListModel.fromJson(response.data);
      selectedSellers = data.list;
      notifyListeners();
      return selectedSellers;
    }
    return null;
  }

  List<NotificationModel> queryComparisonList = [];
  Future<List<NotificationModel>?> getQueryComparisonList(int id) async {
    queryComparisonList = [];
    debugPrint("${ApiLinks.getquerycomparisonlist}?QueryID=$id");
    var response = await DioClient()
        .get("${ApiLinks.getquerycomparisonlist}?QueryID=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is my response====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      var data = BuyerNotificationModelsListModel.fromJson(response.data);
      queryComparisonList = data.list;
      notifyListeners();
      return data.list;
    }
    return null;
  }

  List<QueryModel> historyQueries = [];
  Future<List<QueryModel>?> getHistoryQueryList(int id) async {
    historyQueries = [];
    debugPrint("${ApiLinks.getBuyerHistoryQuery}?BuyerID=$id");
    var response = await DioClient()
        .get("${ApiLinks.getBuyerHistoryQuery}?BuyerID=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is my response====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      var data = ActiveQueryResponseModel.fromJson(response.data);
      historyQueries = data.list!;
      notifyListeners();
      return data.list;
    }
    return null;
  }

  List<NotificationModel> sellersList = [];
  Future getActiveQuerySellerList(int id, bool isActive) async {
    sellersList = [];
    debugPrint("${ApiLinks.getActiveQuerySellerList}?QueryID=$id");
    String url = isActive
        ? ApiLinks.getActiveQuerySellerList
        : ApiLinks.getQuerySellerList;
    var response =
        await DioClient().get("${url}?QueryID=$id").catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return;
    if (response.statusCode == 200) {
      debugPrint("This is my response==================${response.statusCode}");
      debugPrint("This is my response==================${response.data}");
      BuyerNotificationModelsListModel data =
          BuyerNotificationModelsListModel.fromJson(response.data);
      sellersList = data.list;
      notifyListeners();
    }
    return null;
  }

  // Future<List<ImageList>?> getQueryImages(int id) async {
  //   QueryImageModel? data;
  //   debugPrint("${ApiLinks.getQueryImages}?QueryID=$id");
  //   var response = await DioClient()
  //       .get("${ApiLinks.getQueryImages}?QueryID=$id")
  //       .catchError((error) {
  //     debugPrint(error.toString());
  //   });

  //   if (response == null) return null;
  //   debugPrint("This is my response==================${response.statusCode}");
  //   debugPrint("This is my response==================${response.data}");
  //   if (response.statusCode == 200) {
  //     data = QueryImageModel.fromJson(response.data);
  //     debugPrint(data.toString());
  //   }
  //   return data?.list;
  // }

  Future<GetQueryDetailsModel?> getQueryDetails(int id) async {
    GetQueryDetailsModel? data;
    debugPrint("${ApiLinks.getQueryDetails}?QueryID=$id");
    var response = await DioClient()
        .get("${ApiLinks.getQueryDetails}?QueryID=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return null;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      data = GetQueryDetailsModel.fromJson(response.data);
      debugPrint(data.toString());
    }
    return data;
  }

  Future updateQueryStatus(BuildContext context,
      {required int queryID,
      required int buyerID,
      required String status}) async {
    var request = {"queryID": queryID, "buyerID": buyerID, "status": status};
    debugPrint("This is my request====================$request");
    var response = await DioClient()
        .post(ApiLinks.updateQueryStatus, request)
        .catchError((error) {
      Navigator.pop(context);
      debugPrint(error.toString());

      if (error is BadRequestException) {
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: error.toString(),
            backgroundColor: Constants.textColor);
      } else {
        debugPrint(error.toString());
      }
    });

    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      var data = RegisterResponseModel.fromJson(response.data);
      if (data.status == true) {
        await getActiveQueryList(buyerID);
        Navigator.pop(context);
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Success",
            message: data.returnMessage.toString(),
            backgroundColor: Constants.textColor);
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: data.returnMessage.toString(),
            backgroundColor: Constants.textColor);
      }
    } else {
      Navigator.pop(context);
      Utils.showCustomSnackbar(
          context: context,
          title: "Error",
          message: response.toString(),
          backgroundColor: Constants.textColor);
    }
  }

  Future<bool> querySellerSelected(int qsComputerNo) async {
    debugPrint("${ApiLinks.querysellerselected}?qscomputerno=$qsComputerNo");
    var response = await DioClient()
        .post("${ApiLinks.querysellerselected}?qscomputerno=$qsComputerNo")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return false;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> rateSellerSelected(int qsComputerNo, int rate) async {
    debugPrint(
        "${ApiLinks.querysellerrating}?qscomputerno=$qsComputerNo&ratingseller=$rate");
    var response = await DioClient()
        .post(
            "${ApiLinks.querysellerrating}?qscomputerno=$qsComputerNo&ratingseller=$rate")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return false;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      await getselectedSellersList(await GetStorage().read('buyerID'));
      return true;
    }
    return false;
  }

  List<BestSellersModel> bestSellersList = [];
  Future<List<BestSellersModel>?> getBestSellersList() async {
    bestSellersList = [];
    debugPrint("here");
    debugPrint("${ApiLinks.getbestsellerlist}");
    var response = await DioClient()
        .get("${ApiLinks.getbestsellerlist}")
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) null;
    debugPrint("This is statuc code====${response.statusCode}");
    debugPrint("This is my response====${response.data}");
    if (response.statusCode == 200) {
      BestSellersListModel data = BestSellersListModel.fromJson(response.data);
      bestSellersList = data.list;
      notifyListeners();
      return bestSellersList;
    }
    return null;
  }
}
