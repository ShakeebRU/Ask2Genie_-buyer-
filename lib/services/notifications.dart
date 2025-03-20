// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// class NotificationServices {
  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // void requestNotificationPermission() async {
    // NotificationSettings settings = await firebaseMessaging.requestPermission(
    //     alert: true,
    //     announcement: true,
    //     badge: true,
    //     carPlay: true,
    //     criticalAlert: true,
    //     sound: true,
    //     provisional: true);
    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   Get.log("Permission Granted ");
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   Get.log("Provisional Permission Granted ");
    // } else {
    //   Get.log("Not Granted");
    // }
  // }

  // Future<String> getToken() async {
    // String? token = await firebaseMessaging.getToken();
    // return token ?? "";
  // }

  // void isTokenRefresh() {
  //   firebaseMessaging.onTokenRefresh.listen((event) {
  //     event.toString();
  //   });
  // }

  // Future<void> initLocalNotification(
  //     BuildContext context, RemoteMessage message) async {
  //   var androidInitializationSettings =
  //       const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iosInitializationSettings = const DarwinInitializationSettings();
  //   var initializationSettings = InitializationSettings(
  //       android: androidInitializationSettings, iOS: iosInitializationSettings);
  //   await _flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,

  //     //     onDidReceiveBackgroundNotificationResponse: (payload) {
  //     //   handleMessage(context, message);
  //     // }
  //   );
  // }

  // void firebaseInit(BuildContext context) {
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (kDebugMode) {
  //       Get.log(message.notification!.title.toString());
  //       Get.log(message.notification!.body.toString());
  //       print(message.data.toString());
  //     }
  //     initLocalNotification(context, message);
  //     showNotifications(message);
  //   });
  // }

//   Future<void> showNotifications(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         Random.secure().nextInt(10000).toString(),
//         'High Importance Notification',
//         importance: Importance.max);

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             channel.id.toString(), channel.name.toString(),
//             channelDescription: 'Your Channel Description',
//             importance: Importance.high,
//             priority: Priority.high,
//             ticker: 'ticker');

//     const DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );
//     Future.delayed(Duration.zero, () {
//       Get.log("in delay ${message.notification!.title.toString()}");
//       Get.log("in delay ${message.notification!.body.toString()}");
//       Get.log("in delay $notificationDetails");
//       _flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }

//   void handleMessage(BuildContext context, RemoteMessage message) {
//     if (message.data.containsKey(['type'])) {
//       if (message.data['type'] == 'message') {
//         Get.to(() => const NotificationScreen()); //notification screen
//       }
//     } else {
//       Get.log('No Key Found');
//     }
//   }

//   Future<void> setupInteractMessage(BuildContext context) async {
//     /// When app is in Terminated
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       handleMessage(context, initialMessage);
//     }

//     /// When app is in Background

//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       handleMessage(context, event);
//     });
//   }

//   sendNotification({required String name, required String token}) async {
//     getToken().then((value) async {
//       var data = {
//         //'to':'dx6koLvnT1aCHWDfc4orHG:APA91bHpUb5gP4MWJxkAsmoNqKGbgGhMSYjcFaf3X1ifoHAoHZLDM-oSK_mSZox61EMza0XqaSekaKVP5RGVtpDGJGifBim76Vhpm4-WpdG-VNIeUq-1bvadS0kjHfmQvAuQyrfB0q7D',
//         'to': token,
//         'priority': 'high',
//         'notification': {'title': name, 'body': 'Sends You a Message'},
//         'data': {'type': 'message', 'id': '123456'}
//       };
//       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//           body: jsonEncode(data),
//           headers: {
//             'Content-Type': 'application/json; charset=utf-8',
//             'Authorization':
//                 'key=AAAAg93ux7o:APA91bELXVWecuKKRUnRUmx53Yz_pcuL07EMxigsobiQPE_t-iq5la3bJoGLJnFiVEbb7_8Om5d1VIuQdtBVZWHKopHA4cP-S2jlZyQj79E3O0i78gf9gmVV4dKF4C1wjQ3d3bdANt71'
//           });
//     });
//   }
// }
