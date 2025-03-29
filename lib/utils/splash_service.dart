import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../services/get_services.dart';
import '../views/screens/auth/login_screen.dart';
import '../views/screens/auth/otp_screen.dart';
import '../views/screens/dashboard.dart';
import 'utils.dart';

class SplashServices {
  CheckConnectionService checkConnectionService = CheckConnectionService();
  void islogin(BuildContext context) async {
    Timer(const Duration(seconds: 3), () {
      checkConnectionService.checkConnection().then((internet) async {
        if (!internet) {
          Utils.showconnectivityDialog(context, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ),
            );
          });
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) {
          //   return const LoginScreen();
          // }));
          // Utils.showCustomSnackbar(
          //     context: context,
          //     title: "No Internet",
          //     message: "Please Check Your Internet Connection",
          //     backgroundColor: Colors.red);
        } else {
          if (GetStorage().read('buyerID') == null) {
            print("User not Logged in ");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          } else {
            bool statusUser = GetStorage().read('accountStatus');
            print("+++++>${GetStorage().read("token")}");
            print("+++++>${GetStorage().read("accountStatus")}");
            GetStorage().read("token") != null &&
                    GetStorage().read("token") != '' &&
                    GetStorage().read("accountStatus") != null &&
                    statusUser
                ? Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                    return const DashboardScreen();
                  }))
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                    return const OtpScreen(
                      checkRouteLoginExist: false,
                    );
                  }));
            print('_____________________________');
          }
        }
      });
    });
  }
}
