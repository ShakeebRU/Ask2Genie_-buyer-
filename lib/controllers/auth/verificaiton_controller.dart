import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/apilinks.dart';
import '../../models/auth/verification_model.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../utils/utils.dart';
import '../../views/screens/dashboard.dart';

class VerificationController with ChangeNotifier {
  bool resend = false;
  Future verify(BuildContext context, int sellerID, String code) async {
    Utils.showLoadingDialog(context);
    debugPrint(
        "My request====${ApiLinks.verification}?BuyerID=$sellerID&verificationCode=$code");

    var response = await DioClient()
        .post(
            "${ApiLinks.verification}?BuyerID=$sellerID&verificationCode=$code")
        .catchError((error) {
      debugPrint(error.toString());

      if (error is BadRequestException) {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: error.toString(),
            backgroundColor: Colors.red);

        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: "Something went wrong, please try again",
            backgroundColor: Colors.red);
        debugPrint(error.toString());
      }
    });

    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = VerificationModel.fromJson(response.data);

      if (data.status == true) {
        if (data.returnMessage.toString().toLowerCase() == "success") {
          await GetStorage().write("accountStatus", true);
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()));
        } else {
          Navigator.pop(context);
          Utils.showCustomSnackbar(
              context: context,
              title: "Error",
              message: data.returnMessage.toString(),
              backgroundColor: Colors.red);
        }
      } else {
        resend = true;
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: data.returnMessage.toString(),
            backgroundColor: Colors.red);
      }
    }
  }

  Future reSendOtp(BuildContext context, int sellerID) async {
    Utils.showLoadingDialog(context);

    debugPrint(
        "This is my request====================${ApiLinks.verification}?BuyerID=$sellerID");

    var response = await DioClient()
        .post("${ApiLinks.reSendVerification}?BuyerID=$sellerID")
        .catchError((error) {
      debugPrint(error.toString());
      if (error is BadRequestException) {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: error.toString(),
            backgroundColor: Colors.red);
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: "Something went wrong, please try again",
            backgroundColor: Colors.red);
        debugPrint(error.toString());
      }
    });

    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    // debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = VerificationModel.fromJson(response.data);

      if (data.status == true) {
        Navigator.pop(context);
        resend = false;
        notifyListeners();
      } else {
        resend = true;
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: data.returnMessage.toString(),
            backgroundColor: Colors.red);
      }
    }
  }
}
