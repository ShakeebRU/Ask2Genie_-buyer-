import 'package:flutter/material.dart';
import 'package:genie/models/best_sellers_list_mdel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth/query_controller.dart';
import '../../models/auth/logined_model.dart';
import '../../utils/constants.dart';
import '../../utils/preferences.dart';
import '../components/fotter_widget.dart';

class BestSellersScreen extends StatefulWidget {
  List<BestSellersModel> sellersList;
  BestSellersScreen({super.key, required this.sellersList});
  @override
  State<BestSellersScreen> createState() => _BestSellersScreenState();
}

class _BestSellersScreenState extends State<BestSellersScreen> {
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
                    "Best Sellers",
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
                  child: widget.sellersList.isEmpty
                      ? Center(
                          child: Text(
                            "No Sellers Yet",
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
                              children: List.generate(widget.sellersList.length,
                                  (index) {
                                final BestSellersModel tutor =
                                    widget.sellersList[index];
                                return Container(
                                  width: width,
                                  margin: EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Constants.primaryColor,
                                        // Color(0xFFFFFFFF),
                                        // Color(0xFFFFFFFF),
                                        Color.fromARGB(255, 172, 172, 172),
                                        Color.fromARGB(255, 172, 172, 172),
                                        Color.fromARGB(255, 172, 172, 172),
                                        // Color(0xFFFFFFFF),
                                        // Color(0xFFFFFFFF),
                                        Constants.primaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // CircleAvatar(
                                          //   radius: 31,
                                          //   backgroundColor: Colors.white,
                                          //   child: CircleAvatar(
                                          //     backgroundImage:
                                          //         NetworkImage(tutor.imageURL),
                                          //     radius: 30,
                                          //   ),
                                          // ),
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                border: const BorderDirectional(
                                                    bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 2)),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                image: image != null
                                                    ? DecorationImage(
                                                        image: NetworkImage(
                                                          image!,
                                                        ),
                                                        fit: BoxFit.cover)
                                                    : null),
                                          ),
                                          const SizedBox(width: 12.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [
                                                Text(
                                                  tutor.name,
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(width: 6.0),
                                                Icon(
                                                  Icons.verified,
                                                  size: 17,
                                                  color: Constants.primaryColor,
                                                ),
                                                // const SizedBox(width: 6.0),
                                                // Text(tutor.address,
                                                //     style: const TextStyle(fontSize: 15)),
                                              ]),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Constants
                                                          .primaryColor,
                                                      size: 14),
                                                  Text(
                                                      "${tutor.displaySellerRating}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.phone_android,
                                              color: Colors.black, size: 14),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("${tutor.mobileNo}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.category_sharp,
                                              color: Colors.black, size: 14),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "${tutor.categoryList.map((test) => test.categoryName).toList().join(", ")}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.location_city,
                                              color: Colors.black, size: 14),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("${tutor.cityName}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.black, size: 14),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text("${tutor.address}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(height: 10.0),
                                      // SizedBox(
                                      //   width: double.infinity,
                                      //   child: ElevatedButton(
                                      //     onPressed: () async {},
                                      //     style: ElevatedButton.styleFrom(
                                      //       backgroundColor: Colors.white,
                                      //       shape: RoundedRectangleBorder(
                                      //         side: BorderSide(
                                      //           color: Constants.primaryColor,
                                      //         ),
                                      //         borderRadius:
                                      //             BorderRadius.circular(8.0),
                                      //       ),
                                      //       padding: const EdgeInsets.symmetric(
                                      //           vertical: 20.0),
                                      //     ),
                                      //     child: Text(
                                      //       "Start Chat",
                                      //       style: GoogleFonts.outfit(
                                      //         fontSize: 13,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Constants.primaryColor,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
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
