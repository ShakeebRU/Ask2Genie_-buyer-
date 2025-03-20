import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth/query_controller.dart';
import '../../models/auth/logined_model.dart';
import '../../models/query/query_details_model.dart';
import '../../models/query/query_image_model.dart';
import '../../models/query/query_model.dart';
import '../../utils/constants.dart';
import '../../utils/preferences.dart';
import '../../utils/utils.dart';
import '../components/fotter_widget.dart';
import 'detail_query_screen.dart';
import 'sellers_list_screen.dart';

class ActiveQueryScreen extends StatefulWidget {
  const ActiveQueryScreen({super.key});

  @override
  State<ActiveQueryScreen> createState() => _ActiveQueryScreenState();
}

class _ActiveQueryScreenState extends State<ActiveQueryScreen> {
  String name = "";
  String? image;
  @override
  void initState() {
    super.initState();
    updateName();
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

    return Consumer<QueryController>(builder: (context, controller, index) {
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
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                border: const BorderDirectional(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 2)),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                image: image != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          image!,
                                        ),
                                        fit: BoxFit.cover)
                                    : null),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: GoogleFonts.anta().fontFamily,
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: width * 0.8,
                  child: Text(
                    "Active Queries",
                    textAlign: TextAlign.center,
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
                  child: controller.activeQueries.isEmpty
                      ? Center(
                          child: Text(
                            "No Active Query",
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
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                  controller.activeQueries.length, (index) {
                                QueryModel data =
                                    controller.activeQueries[index];
                                var result =
                                    Utils.formatDateTime(data.dueDateTime);
                                String? dueDate = result['date'];
                                String? dueTime = result['time'];
                                String queryTime =
                                    Utils.getTimeElapsed(data.queryDateTime);
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      height: 85,
                                      width: width * 0.85,
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                // height: 20,
                                                child: Text(
                                                  queryTime,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 6,
                                                    fontFamily:
                                                        GoogleFonts.akatab()
                                                            .fontFamily,
                                                    color: Constants.textColor,
                                                    // letterSpacing: 1,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFC4C4C4),
                                                  border:
                                                      const BorderDirectional(
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: Colors
                                                                  .white)),
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
                                                        data.docURL,
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
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 80,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.productName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily:
                                                          GoogleFonts.akatab()
                                                              .fontFamily,
                                                      color: Constants
                                                          .textPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.categoryName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontFamily:
                                                          GoogleFonts.akatab()
                                                              .fontFamily,
                                                      color: Constants
                                                          .textPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.brandModel,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontFamily:
                                                          GoogleFonts.akatab()
                                                              .fontFamily,
                                                      color: Constants
                                                          .textPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 85,
                                            width: 115,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Valid Till",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        GoogleFonts.akatab()
                                                            .fontFamily,
                                                    color:
                                                        const Color(0xFF3AFF03),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Container(
                                                  width: 115,
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        dueDate.toString(),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          wordSpacing: 1,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .akatab()
                                                                  .fontFamily,
                                                          color: Constants
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        dueTime.toString(),
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          wordSpacing: 1,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .akatab()
                                                                  .fontFamily,
                                                          color: Constants
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        Utils.showLoadingDialog(
                                                            context);
                                                        GetQueryDetailsModel?
                                                            queryDetail =
                                                            await controller
                                                                .getQueryDetails(
                                                                    data.queryID!);
                                                        QueryMediaModel?
                                                            queryMedia =
                                                            QueryMediaModel(
                                                                listimage: queryDetail!
                                                                    .listimage,
                                                                listaudio:
                                                                    queryDetail
                                                                        .listaudio,
                                                                listvideo:
                                                                    queryDetail
                                                                        .listvideo);
                                                        // List<ImageList>? queryImages =
                                                        //     await controller
                                                        //         .getQueryImages(
                                                        //             data.queryID!);
                                                        Navigator.pop(context);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return DetailQueryScreen(
                                                            isActive: true,
                                                            query: queryDetail
                                                                    .list ??
                                                                data,
                                                            queryImages:
                                                                queryMedia,

                                                            // audio: '',
                                                            // vedio: '',
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
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 3,
                                                                spreadRadius: 1,
                                                                offset: Offset(
                                                                    0, 3),
                                                              ),
                                                            ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Color(
                                                                          0xFF333333),
                                                                      Color(
                                                                          0xFF747474)
                                                                    ])),
                                                        child: Center(
                                                          child: Text(
                                                            "Details",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white,
                                                                wordSpacing: 2,
                                                                fontFamily: GoogleFonts
                                                                        .akatab()
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        Utils.showLoadingDialog(
                                                            context);
                                                        await controller
                                                            .getActiveQuerySellerList(
                                                                data.queryID!,
                                                                false);
                                                        Navigator.pop(context);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const SellersListScreen();
                                                        }));
                                                        // await controller
                                                        //     .updateQueryStatus(
                                                        //         context,
                                                        //         queryID:
                                                        //             data.queryID!,
                                                        //         buyerID:
                                                        //             await GetStorage()
                                                        //                 .read(
                                                        //                     'buyerID'),
                                                        //         status: "Closed");
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        width: 50,
                                                        decoration:
                                                            const BoxDecoration(
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 3,
                                                                spreadRadius: 1,
                                                                offset: Offset(
                                                                    0, 3),
                                                              ),
                                                            ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Color(
                                                                          0xFF333333),
                                                                      Color(
                                                                          0xFF747474)
                                                                    ])),
                                                        child: Center(
                                                          child: Text(
                                                            "Sellers",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white,
                                                                wordSpacing: 2,
                                                                fontFamily: GoogleFonts
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
                FootterWidget(height: height, width: width)
              ],
            ),
          ),
        ),
      );
    });
  }
}
