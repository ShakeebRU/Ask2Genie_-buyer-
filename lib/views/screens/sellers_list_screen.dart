import 'package:flutter/material.dart';
import 'package:genie/models/query/seller_query_reponse_mode.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../controllers/auth/query_controller.dart';
import '../../controllers/chat/chat_controller.dart';
import '../../models/auth/logined_model.dart';
import '../../models/query/buyer_notification_list_model.dart';
import '../../models/query/query_details_model.dart';
import '../../utils/preferences.dart';
import '../../utils/utils.dart';
import 'chat_page_screen.dart';
import 'quoptation_detail_screen.dart';

class SellersListScreen extends StatefulWidget {
  const SellersListScreen({super.key});

  @override
  State<SellersListScreen> createState() => _SellersListScreenState();
}

class _SellersListScreenState extends State<SellersListScreen> {
  ChatController chatController = Get.put<ChatController>(ChatController());
  String name = "";
  String? image;
  @override
  void initState() {
    super.initState();
    updateName();
  }

  String getNotificationString({
    required int conditionNew,
    required int conditionUsed,
    required int alternateProduct,
  }) {
    // Initialize an empty list to hold condition labels
    List<String> conditions = [];

    // Check each condition and add the corresponding label to the list
    if (conditionNew == 1) {
      conditions.add("New");
    }
    if (conditionUsed == 1) {
      conditions.add("Used");
    }
    if (alternateProduct == 1) {
      conditions.add("Alternate");
    }

    // Join the list into a single string with ", " as the separator
    return conditions.join(", ");
  }

  void updateName() async {
    UserDataLogin? user =
        await Preferences.init().then((onValue) => onValue.getAuth());
    if (user != null) {
      name = user.name;
      image = user.imageURL;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<QueryController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Constants.secondaryColor,
          body: SizedBox(
            height: height - 20,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
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
                                          colors: [
                                            Color(0xFF333333),
                                            Color(0xFF747474)
                                          ])),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 13,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/images/genieLamp.png",
                            height: 60,
                            width: 60,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Ask2Genie",
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Jaro',
                              color: Constants.primaryColor,
                              height: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: const BorderDirectional(
                                bottom:
                                    BorderSide(color: Colors.white, width: 2)),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            image: image != "" && image != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(image!),
                                  )
                                : const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/newImages/testimg.png')),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: width * 0.8,
                  child: Text(
                    "Quotes",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.anta().fontFamily,
                      color: Constants.textColor,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: controller.sellersList.isEmpty
                      ? Center(
                          child: Text(
                            "No Seller",
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: GoogleFonts.anta().fontFamily,
                              color: Constants.textPrimaryColor,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 10.0,
                              runSpacing: 16.0,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                  controller.notificationsList.length, (index) {
                                NotificationModel notification =
                                    controller.notificationsList[index];
                                String queryTime = Utils.getTimeElapsed(
                                    notification.queryDateTime);
                                return GestureDetector(
                                  // onTap: () async {

                                  // },
                                  child: Container(
                                      height: 114,
                                      width: width * 0.8,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Constants.secondaryColor,
                                        border: BorderDirectional(
                                            bottom: BorderSide(
                                                color: Constants.primaryColor,
                                                width: 0.7)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                queryTime.toString(),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontFamily:
                                                      GoogleFonts.akatab()
                                                          .fontFamily,
                                                  color: Constants.textColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        notification
                                                            .sellerImageURL,
                                                      ),
                                                      fit: BoxFit.cover),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        offset:
                                                            const Offset(0, 2),
                                                        spreadRadius: 0.6,
                                                        color: Colors.white
                                                            .withOpacity(0.4))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 45,
                                                height: 20,
                                                child: Text(
                                                  notification.sellerName,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    color:
                                                        Constants.primaryColor,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 45,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Constants
                                                          .primaryColor,
                                                      size: 10,
                                                    ),
                                                    Text(
                                                      notification
                                                          .displaySellerRating
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFFFCC00),
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 80,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 10),
                                              child: Text(
                                                notification.sellerRemarks,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily:
                                                      GoogleFonts.akatab()
                                                          .fontFamily,
                                                  color: Constants.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                margin: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFC4C4C4),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  ),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        notification.docURL,
                                                      ),
                                                      fit: BoxFit.cover),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 1,
                                                        offset:
                                                            const Offset(0, 2),
                                                        spreadRadius: 0.6,
                                                        color: Colors.white
                                                            .withOpacity(0.4))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Utils.showLoadingDialog(
                                                      context);
                                                  QuotationDataModel? res =
                                                      await controller
                                                          .getSelleryQueryResponse(
                                                              notification
                                                                  .qsComputerNo);
                                                  // GetQueryDetailsModel?
                                                  //     queryDetail =
                                                  //     await controller
                                                  //         .getQueryDetails(
                                                  //             data.queryID!);
                                                  // QueryMediaModel?
                                                  //     queryMedia =
                                                  //     QueryMediaModel(
                                                  //         listimage: queryDetail!
                                                  //             .listimage,
                                                  //         listaudio:
                                                  //             queryDetail
                                                  //                 .listaudio,
                                                  //         listvideo:
                                                  //             queryDetail
                                                  //                 .listvideo);
                                                  Navigator.pop(context);
                                                  if (res != null) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return QuotationQuerySCreen(
                                                        query: res!,
                                                      );
                                                    }));
                                                  }
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 3,
                                                          spreadRadius: 1,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color(
                                                                    0xFF333333),
                                                                Color(
                                                                    0xFF747474)
                                                              ])),
                                                  child: Center(
                                                    child: Text(
                                                      "Details",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          wordSpacing: 2,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .akatab()
                                                                  .fontFamily,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            height: 130,
                                            width: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  notification.chatCount == 0
                                                      ? "New Query"
                                                      : "Chating",
                                                  style: TextStyle(
                                                      color: notification
                                                                  .chatCount ==
                                                              0
                                                          ? Colors.green
                                                          : Color(0xFFFFCC00),
                                                      fontFamily:
                                                          GoogleFonts.anta()
                                                              .fontFamily,
                                                      fontSize: 9),
                                                ),
                                                Text(
                                                  notification.productName,
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    fontFamily:
                                                        GoogleFonts.akatab()
                                                            .fontFamily,
                                                    color: Constants.textColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  notification.itemCondition,
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    fontFamily:
                                                        GoogleFonts.akatab()
                                                            .fontFamily,
                                                    color: Constants.textColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  notification.rate.toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        GoogleFonts.akatab()
                                                            .fontFamily,
                                                    color: Constants.textColor,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    print(
                                                        "Chat :  ${notification.sellerImageURL}");

                                                    await chatController
                                                        .getQueryMinRateList(
                                                            notification
                                                                .queryID);
                                                    GetQueryDetailsModel?
                                                        queryDetail =
                                                        await controller
                                                            .getQueryDetails(
                                                                notification
                                                                    .queryID!);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return ChatPageScreen(
                                                        fcmToken: queryDetail!
                                                            .list!
                                                            .buyerDeviceToken,
                                                        rate: chatController
                                                            .queryMinRateList!,
                                                        name: notification
                                                            .sellerName,
                                                        queryImage:
                                                            notification.docURL,
                                                        sellerID: notification
                                                            .sellerID,
                                                        isActive: true,
                                                        groupId: notification
                                                            .qsComputerNo
                                                            .toString(),
                                                        profileImage:
                                                            notification
                                                                .sellerImageURL,
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                            boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 3,
                                                            spreadRadius: 1,
                                                            offset:
                                                                Offset(0, 3),
                                                          ),
                                                        ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      0.0),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                                  Color(
                                                                      0xFF333333),
                                                                  Color(
                                                                      0xFF747474)
                                                                ])),
                                                    child: Center(
                                                      child: Text(
                                                        "Chat",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            wordSpacing: 2,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .akatab()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
