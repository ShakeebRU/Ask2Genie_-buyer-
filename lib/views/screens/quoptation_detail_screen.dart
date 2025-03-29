import 'package:flutter/material.dart';
import 'package:genie/controllers/chat/chat_screen_controller.dart';
import 'package:genie/models/query/seller_query_reponse_mode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth/query_controller.dart';
import '../../models/auth/logined_model.dart';
import '../../models/query/buyer_notification_list_model.dart';
import '../../utils/constants.dart';
import '../../utils/preferences.dart';
import '../../utils/utils.dart';
import '../components/custum_checkbox.dart';
import '../components/image_gellery.dart';
import '../components/rate_seller_widget.dart';

class QuotationQuerySCreen extends StatefulWidget {
  final QuotationDataModel query;
  const QuotationQuerySCreen({
    super.key,
    required this.query,
  });

  @override
  State<QuotationQuerySCreen> createState() => _QuotationQuerySCreenState();
}

class _QuotationQuerySCreenState extends State<QuotationQuerySCreen> {
  bool isNewChecked = false;
  bool isUsedChecked = false;
  bool isAlternateChecked = false;
  String dueDate = '';
  String dueTime = '';
  String queryTime = '';
  List<String> queryImages = [];
  List<String> queryVedio = [];
  List<String> queryAudio = [];
  void setData() {
    var result = Utils.formatDateTime(widget.query.dueDateTime!);
    dueDate = result['date']!;
    dueTime = result['time']!;
    queryTime = Utils.getTimeElapsed(widget.query.queryDateTime!);
    isNewChecked = widget.query.conditionNew == 1;
    isUsedChecked = widget.query.conditionUsed == 1;
    isAlternateChecked = widget.query.alternateProduct == 1;
    queryImages = widget.query.chatDetail
        .map((test) => test.messageType == MessageType.image.toLowerCase()
            ? test.docURL
            : null)
        .where((url) => url != null) // Remove null values
        .cast<String>() // Cast to List<String>
        .toList();
    queryVedio = widget.query.chatDetail
        .map((test) =>
            test.messageType.toLowerCase() == MessageType.video.toLowerCase()
                ? test.docURL
                : null)
        .where((url) => url != null) // Remove null values
        .cast<String>() // Cast to List<String>
        .toList();

    queryAudio = widget.query.chatDetail
        .map((test) =>
            test.messageType.toLowerCase() == MessageType.audio.toLowerCase()
                ? test.docURL
                : null)
        .where((url) => url != null) // Remove null values
        .cast<String>() // Cast to List<String>
        .toList();
    setState(() {});
  }

  Future<int?> showRateSellerDialog(
      BuildContext context, NotificationModel notification) async {
    int? result = await showDialog(
      context: context,
      builder: (context) => RateSellerDialog(notification: notification),
    );
    return result;
  }

  String name = "";
  String? image;
  @override
  void initState() {
    super.initState();
    updateName();
    setData();
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
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 30,
                          width: width * 0.8,
                          child: Text(
                            "Query Details",
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
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          // height: 30,
                          width: width * 0.8,
                          child: Text(
                            widget.query.productName!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: GoogleFonts.akatab().fontFamily,
                              color: Constants.textColorBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            widget.query.categoryName!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: GoogleFonts.akatab().fontFamily,
                              color: Constants.textPrimaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            widget.query.brandModel!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: GoogleFonts.akatab().fontFamily,
                              color: Constants.textPrimaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            widget.query.productDescription!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: GoogleFonts.antic().fontFamily,
                              color: Constants.textPrimaryColor,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    widget.query.itemCondition.toLowerCase() !=
                                            "new"
                                        ? SizedBox.shrink()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomCheckBox(
                                                height: 25,
                                                width: 25,
                                                color: Constants.disableColor,
                                                value:
                                                    widget.query.conditionNew ==
                                                        1,
                                                onChanged: (value) {
                                                  // setState(() {
                                                  //   isNewChecked = value!;
                                                  // });
                                                },
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'New',
                                                style: TextStyle(
                                                    color:
                                                        Constants.disableColor,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                    widget.query.itemCondition.toLowerCase() !=
                                            "new"
                                        ? SizedBox.shrink()
                                        : const SizedBox(
                                            width: 20,
                                          ),
                                    widget.query.itemCondition.toLowerCase() !=
                                            "ssed"
                                        ? SizedBox.shrink()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomCheckBox(
                                                height: 25,
                                                width: 25,
                                                color: Constants.disableColor,
                                                value: widget
                                                        .query.conditionUsed ==
                                                    1,
                                                onChanged: (value) {
                                                  // setState(() {
                                                  //   isUsedChecked = value!;
                                                  // });
                                                },
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Used',
                                                style: TextStyle(
                                                    color:
                                                        Constants.disableColor,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                    widget.query.itemCondition.toLowerCase() !=
                                            "alternate"
                                        ? SizedBox.shrink()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              CustomCheckBox(
                                                height: 25,
                                                width: 25,
                                                color: Constants.disableColor,
                                                value: widget.query
                                                        .alternateProduct ==
                                                    1,
                                                onChanged: (value) {
                                                  // setState(() {
                                                  //   isUsedChecked = value!;
                                                  // });
                                                },
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Alternate\nProduct',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color:
                                                        Constants.disableColor,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    "Valid Till",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.anta().fontFamily,
                                      color: const Color(0xFF3AFF03),
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    dueDate,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.anta().fontFamily,
                                      color: Colors.red,
                                      // letterSpacing: 1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 115,
                                  child: Text(
                                    dueTime,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.anta().fontFamily,
                                      color: Colors.red,
                                      // letterSpacing: 1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  // onTap: () async {
                                  //   await _showQuantityDialog(context);
                                  //   setState(() {});
                                  // },
                                  child: Container(
                                    height: 30,
                                    // width: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Constants.disableColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.query.qty.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Constants.disableColor,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      color: Constants.disableColor,
                                      fontFamily: GoogleFonts.anta().fontFamily,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 130,
                          child: Text(
                            "Rate : ${widget.query.rate}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.anta().fontFamily,
                              color: const Color(0xFF3AFF03),
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        queryVedio.isEmpty
                            ? const SizedBox()
                            : const SizedBox(
                                height: 20,
                              ),
                        queryVedio.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (queryVedio.isNotEmpty) {
                                    await Utils.showVideoDialog(
                                        context, queryVedio.first, true);
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      // onTap: () async {
                                      //   if (widget
                                      //       .queryImages.listvideo!.isNotEmpty) {
                                      //     await Utils.showVideoDialog(
                                      //         context,
                                      //         widget.queryImages.listvideo!.first,
                                      //         true);
                                      //   }
                                      // },
                                      child: Container(
                                        height: 90,
                                        // width: 90,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0XFFDCDCDC)
                                                  .withOpacity(0.6)),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            bottomLeft: Radius.circular(0.0),
                                            topRight: Radius.circular(16),
                                            bottomRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Container(
                                          height: 60,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: queryVedio.isEmpty
                                                ? null
                                                : DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        queryVedio.first)),
                                            border: queryVedio.isEmpty
                                                ? null
                                                : BorderDirectional(
                                                    bottom: BorderSide(
                                                        width: 2,
                                                        color: const Color(
                                                                0XFFDCDCDC)
                                                            .withOpacity(0.6))),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16)),
                                          ),
                                          child: queryVedio.isNotEmpty
                                              ? null
                                              : Center(
                                                  child: Text(
                                                    "No\nVideo",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          GoogleFonts.anta()
                                                              .fontFamily,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Image.asset(
                                          height: 30,
                                          width: 30,
                                          "assets/newImages/Play.png"),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        queryAudio.isEmpty
                            ? const SizedBox()
                            : const SizedBox(
                                height: 20,
                              ),
                        queryAudio.isNotEmpty
                            ? Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (queryAudio.isNotEmpty) {
                                        await Utils.playBase64AudioWithControls(
                                            context, queryAudio.first, true);
                                      }
                                    },
                                    child: Container(
                                      height: 90,
                                      // width: 90,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: const Color(0XFFDCDCDC)
                                                .withOpacity(0.6)),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: Container(
                                        height: 60,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          image: queryAudio.isEmpty
                                              ? null
                                              : const DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      "assets/newImages/microphone.png")),
                                          border: queryAudio.isEmpty
                                              ? null
                                              : BorderDirectional(
                                                  bottom: BorderSide(
                                                      width: 2,
                                                      color: const Color(
                                                              0XFFDCDCDC)
                                                          .withOpacity(0.6))),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              bottomLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(16),
                                              bottomRight: Radius.circular(16)),
                                        ),
                                        child: queryAudio.isNotEmpty
                                            ? null
                                            : Center(
                                                child: Text(
                                                  "No\nAudio",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Image.asset(
                                        height: 30,
                                        width: 30,
                                        "assets/newImages/Volume.png"),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        queryImages.isEmpty
                            ? const SizedBox()
                            : const SizedBox(
                                height: 20,
                              ),
                        queryImages.isEmpty
                            ? const SizedBox()
                            : Container(
                                // height: 90,
                                // width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0XFFDCDCDC)
                                          .withOpacity(0.6)),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16)),
                                  ),
                                  child: queryImages.isEmpty
                                      ? Center(
                                          child: Text(
                                            "No\nImage",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  GoogleFonts.anta().fontFamily,
                                              fontSize: 10,
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: ImageGallery(
                                            images: queryImages
                                                .map((toElement) => toElement)
                                                .toList(),
                                            isMemoryImage: false,
                                            deleteable: false,
                                            isOpen: false,
                                            imageHeight: 90,
                                            imageWidth: 90,
                                            lenght: 6,
                                          ),
                                        ),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
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
