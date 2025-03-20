import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/apilinks.dart';
import '../../models/auth/category_list_model.dart';
import '../../models/auth/city_list_model.dart';
import '../../models/auth/country_list_model.dart';
import '../../models/auth/firebase_info_model.dart';
import '../../models/auth/login_response_model.dart';
import '../../models/auth/logined_model.dart';
import '../../models/auth/register_model.dart';
import '../../models/auth/register_response_model.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../services/notifications.dart';
import '../../utils/preferences.dart';
import '../../utils/utils.dart';
import '../../views/screens/auth/otp_screen.dart';
import '../../views/screens/dashboard.dart';

class AuthController with ChangeNotifier {
  //register controller
  CategoryResponseModel catagoriesList = CategoryResponseModel();
  CityListModel cityList = CityListModel();
  CountryListModel countryList = CountryListModel();
  var selectedCountryName = 'Pakistan';
  var selectedCountryId = 1;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String deviceType = '';
  String deviceId = '';
  var token;

  Future getContryList() async {
    debugPrint(ApiLinks.getCountry);
    var response =
        await DioClient().get(ApiLinks.getCountry).catchError((error) {
      debugPrint(error.toString());
    });
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      countryList = CountryListModel.fromJson(response.data);
    }

    return null;
  }

  Future getCityList() async {
    debugPrint(ApiLinks.getCity);
    var response = await DioClient().get(ApiLinks.getCity).catchError((error) {
      debugPrint(error.toString());
    });
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      cityList = CityListModel.fromJson(response.data);
      notifyListeners();
    }
    return null;
  }

  Future getCatagoryList() async {
    debugPrint(ApiLinks.getCategories);
    var response =
        await DioClient().get(ApiLinks.getCategories).catchError((error) {
      debugPrint(error.toString());
    });
    print(response);
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      catagoriesList = CategoryResponseModel.fromJson(response.data);
      notifyListeners();
    }
    return null;
  }

  //  Future getCategoryList() async {
  //   // openLoader();
  //   debugPrint(ApiLinks.getCategories);
  //   //DialogBoxes.openLoadingDialog();
  //   var response =
  //       await DioClient().get(ApiLinks.getCategories).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //   // if (response == null) return;
  //   debugPrint("This is my response==================${response.statusCode}");
  //   debugPrint("This is my response==================${response.data}");
  //   // debugPrint(response.statusCode.toString());
  //    if (response.statusCode == 200) {
  //        categoryList.value = CategoryResponseModel.fromJson(response.data);
  //    }
  //   return null;
  //   // return null;
  // }

  // Future getProfile(int id) async {
  //   var response = await DioClient()
  //       .get("${ApiLinks.buyerDetails}?BuyerID=$id")
  //       .catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //   if (response == null) return;
  //   debugPrint("This is my response==================${response.statusCode}");
  //   debugPrint("This is my response==================${response.data}");
  //   if (response.statusCode == 200) {
  //     var data = ProfileResponseModel.fromJson(response.data);
  //     if (data.status == true) {
  //       profileData.value = data;
  //       image.value = data.list?.imageURL ?? '';
  //       Get.log("profile image : ${data.list?.imageURL}");
  //       debugPrint(profileData.value.list?.cityName);
  //       update();
  //     } else {
  //       debugPrint("here");
  //     }
  //   }
  // }

  Future uploadImage(BuildContext context, String image, int computerNo) async {
    var request = {"computerNo": computerNo, "imageBase64": image};
    debugPrint("This is my request====================$request");

    var response = await DioClient()
        .post(ApiLinks.buyerupdateimage, request)
        .catchError((error) {
      debugPrint(error.toString());
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());
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
        // await getProfile(computerNo);
        Utils.showCustomSnackbar(
            context: context,
            title: "Success",
            message: data.returnMessage.toString(),
            backgroundColor: Colors.red);
      } else {
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: data.returnMessage.toString(),
            backgroundColor: Colors.red);
      }
    }
  }

  Future firebaseInsert(
      {required int id, required String firebaseId, required fcmToken}) async {
    var request = {
      "buyerID": id,
      "deviceID": fcmToken,
      "deviceType": 'Android',
      "firebaseID": firebaseId
    };
    debugPrint("This is my request====================$request");
    var response = await DioClient()
        .post(ApiLinks.insertFirebase, request)
        .catchError((error) {
      debugPrint(error.toString());
    });
    if (response == null) return;
    debugPrint(
        "This is my response fire==================${response.statusCode}");
    debugPrint("This is my response fire==================${response.data}");
  }

  Future<void> registerUser(
    BuildContext context, {
    required int id,
    required String email,
    required String pas,
    required String name,
    required String city,
    required String country,
    required String phone,
    required String image,
  }) async {
    // Utils.showLoadingDialog(context);
    try {
      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: pas);
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      //     .set({
      //   'id': FirebaseAuth.instance.currentUser!.uid.toString(),
      //   'email': email,
      //   'password': pas,
      //   'name': name,
      //   'city': city,
      //   'country': country,
      //   'phone': phone,
      //   'role': "Buyer",
      //   'status': "Offline",
      // }, SetOptions(merge: true)).then((value) async {
      //   NotificationServices().getToken().then((value) {
      //     token = value;
      //   });
      //   await firebaseInsert(
      //       id: int.parse(id.toString()),
      //       firebaseId: FirebaseAuth.instance.currentUser!.uid,
      //       fcmToken: token);
      // }).onError((error, stackTrace) {
      // Navigator.pop(context);
      // Utils.showCustomSnackbar(
      //     context: context,
      //     title: "Unsuccessful Login",
      //     message: error.toString(),
      //     backgroundColor: Colors.red);
      // });
    } catch (e) {
      // Navigator.pop(context);
      // Utils.showCustomSnackbar(
      //     context: context,
      //     title: "Error",
      //     message: e.toString(),
      //     backgroundColor: Colors.red);
    }
  }

  Future<void> register(
      BuildContext context,
      String name,
      String email,
      String password,
      String phone,
      String companyName,
      List<CategoryListdata> businessType,
      CityModel? city,
      String about,
      String address,
      String lat,
      String lng,
      String image) async {
    Utils.showLoadingDialog(context);
    var request = {
      'email': email,
      'password': password,
      'name': name,
      'mobileNo': phone,
      "buyerID": 0,
      "cityID": city?.cityID ?? 0,
      "cityName": city?.cityName ?? "",
      "countryID": selectedCountryId,
      "countryName": selectedCountryName.toString(),
      "address": address,
      "longitude": lng,
      "latitude": lat,
      "description": "",
      // "status": "string",
      "companyName": companyName,
      "aboutDetail": about,
      "categoryList": businessType
    };
    debugPrint("My request====>$request");
    var response =
        await DioClient().post(ApiLinks.register, request).catchError((error) {
      debugPrint(error.toString());
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: error.toString(),
            backgroundColor: Colors.red);
      } else {
        debugPrint(error);
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: error.toString(),
            backgroundColor: Colors.red);
      }
    });
    if (response == null) return;

    debugPrint("This is my response====> ${response.statusCode}");
    debugPrint("This is my response====> ${response.data}");
    if (response.statusCode == 200) {
      var data = RegisterResponseModel.fromJson(response.data);
      if (data.status == true) {
        RegisteredModel userData = RegisteredModel.fromJson(response.data);
        await registerUser(context,
            id: int.parse(data.returnId!.toString()),
            city: city?.cityID?.toString() ?? "",
            country: selectedCountryId.toString(),
            pas: password,
            phone: phone,
            email: email,
            name: name,
            image: image);
        if (image.isNotEmpty) {
          await uploadImage(
              context, image, int.parse(data.returnId!.toString()));
        }

        Navigator.pop(context);
        // await Preferences.init()
        //     .then((onValue) => onValue.saveCridentials(userData.list));
        // await GetStorage().write("VerificationCode", userData.verificationcode);
        selectedCountryName = 'Select Country';
        selectedCountryId = 0;
        // Navigator.pop(context);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //   return const OtpScreen(
        //     checkRouteLoginExist: true,
        //   );
        // }));
        // Utils.showCustomSnackbar(
        //     context: context,
        //     title: "Successfully Registered",
        //     message: "Account Created Successfully",
        //     backgroundColor: Colors.red);
        await login(context, userData.list.mobileNo, password);
        // selectedCityName = 'Select City';
        // selectedCityId = 0;
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: data.returnMessage.toString(),
            backgroundColor: Colors.red);
      }
    }
  }

  //+++++++++++++++++++++++++<login controller>+++++++++++++++++++++++++++++++

  // FirebaseAuth auth = FirebaseAuth.instance;

  void onInit() async {
    if (Platform.isAndroid) {
      deviceType = 'android';

      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
      debugPrint("android id${androidInfo.id}");
    } else if (Platform.isIOS) {
      deviceType = 'ios';

      IosDeviceInfo infoIos = await deviceInfoPlugin.iosInfo;
      deviceId = infoIos.identifierForVendor ?? '';
      debugPrint(infoIos.identifierForVendor.toString());
    }

    notifyListeners();
  }

  Future<FireBaseInfoModel?> getFirebaseInfo(int id) async {
    FireBaseInfoModel? data;
    debugPrint(ApiLinks.getFirebase);
    var response = await DioClient()
        .get("${ApiLinks.getFirebase}?BuyerID=$id")
        .catchError((error) {
      debugPrint(error.toString());
    });

    // if (response == null) return;
    debugPrint("This is my response==========${response.statusCode}");
    debugPrint("This is my response data=====${response.data}");
    if (response.statusCode == 200) {
      data = FireBaseInfoModel.fromJson(response.data);
    }
    notifyListeners();
    return data;
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    Utils.showLoadingDialog(context);
    var request = {
      'mobileNo': email,
      'password': password,
    };
    debugPrint("This is my request====================$request");
    var response = await DioClient()
        .post(ApiLinks.buyerlogin, request)
        .catchError((error) {
      debugPrint(error.toString());
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: apiError,
            backgroundColor: Colors.red);
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: error.toString(),
            backgroundColor: Colors.red);
      }
    });
// dataLogin
    if (response == null) return;
    debugPrint("This is my response==================${response.statusCode}");
    debugPrint("This is my response==================${response.data}");
    if (response.statusCode == 200) {
      var dataLogin = LoginResponse.fromJson(response.data);
      if (dataLogin.status == true) {
        var data = LoginedModel.fromJson(response.data);
        // await FirebaseMessaging.instance
        //     .subscribeToTopic('buyer${data.list.buyerID}');
        LoginedModel userData = LoginedModel.fromJson(response.data);
        await GetStorage().write("VerificationCode", userData.verificationcode);
        await Preferences.init()
            .then((onValue) => onValue.saveCridentials(userData.list));
        await GetStorage().write("buyerID", data.list.buyerID);
        await GetStorage().write("token", data.list.token);
        await GetStorage().write("accountStatus", data.userstatus);
        await GetStorage().write("name", data.list.name);
        print("++++> Api Id is ${data.list.buyerID}");
        // await loginUser(
        //   mail: userData.list.mobileNo,
        //   pass: password,
        // ).then((value) async {
        //   NotificationServices().getToken().then((value) {
        //     token = value;
        //     print("token is $token");
        //     print("Firebase ID is ${FirebaseAuth.instance.currentUser!.uid}");
        //   });
        // await NotificationServices().getToken().then((value) {
        //   token = value;
        // });
        // await firebaseInsert(
        //     id: data.list.buyerID,
        //     firebaseId: FirebaseAuth.instance.currentUser!.uid,
        //     fcmToken: token);
        print("+++++++ before call Function ");
        if (data.userstatus == true) {
          print("++++> Api user status true");
          // await Provider.of<HomeController>(context, listen: false)
          //     .getActiveQueryList(data.buyerID!);
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const DashboardScreen();
          }));
        } else {
          print("++++> Api user status false");
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const OtpScreen(
              checkRouteLoginExist: true,
            );
          }));
        }
        // }).catchError((error) {
        //   Navigator.pop(context);
        //   Utils.showCustomSnackbar(
        //       context: context,
        //       title: "Error",
        //       message: error.toString(),
        //       backgroundColor: Colors.red);
        // });
      } else {
        Navigator.pop(context);
        Utils.showCustomSnackbar(
            context: context,
            title: "Error",
            message: dataLogin.message.toString(),
            backgroundColor: Colors.red);
      }
    }
  }

  // Future<void> loginUser({required String mail, required String pass}) async {
  //   try {
  //     print("mail sent to controller is $mail");
  //     print("mail sent to controller is $pass");
  //     await auth
  //         .signInWithEmailAndPassword(email: mail, password: pass)
  //         .then((value) async {
  //       print('Current User Logged in  is --------------- $mail');
  //     }).onError((error, stackTrace) {
  //       print("login User error : ${error.toString()}");
  //     });
  //   } catch (e) {
  //     print('Catch Portion ${e.toString()}');
  //   }
  // }
}
