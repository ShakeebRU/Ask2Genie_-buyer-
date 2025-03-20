import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/auth/category_list_model.dart';
import '../../../utils/constants.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/query_controller.dart';
import '../../utils/utils.dart';
import '../components/custum_checkbox.dart';
import '../components/drop_down_widget.dart';
import '../components/image_gellery.dart';
import '../components/input_field_widget.dart';

class NewQueryScreen extends StatefulWidget {
  const NewQueryScreen({super.key});

  @override
  State<NewQueryScreen> createState() => _NewQueryScreenState();
}

class _NewQueryScreenState extends State<NewQueryScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController catagoryController = TextEditingController();
  List<String> images = [];
  String? vedio;
  String? audio;
  CategoryListdata? selectedCatagoryList;
  int quantity = 1; // Default quantity
  bool isDateChanged = false;
  bool isNewChecked = false; // Checkbox for "New"
  bool isUsedChecked = false; // Checkbox for "Used"
  bool isAlternateChecked = false; // Checkbox for "Alternate Product"
  DateTime selectedDateTime = DateTime.now().add(const Duration(days: 1));

  Future<void> _showQuantityDialog(BuildContext context) async {
    int tempQuantity = quantity; // Initialize tempQuantity outside the builder
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Constants.secondaryColor,
              title: Text('Enter Quantity',
                  style: TextStyle(color: Constants.primaryColor)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Constants.textColor),
                    onPressed: () {
                      if (tempQuantity > 0) {
                        setState(() {
                          tempQuantity--; // Update using the dialog's setState
                        });
                      }
                    },
                  ),
                  Text(
                    tempQuantity.toString(),
                    style:
                        TextStyle(fontSize: 20, color: Constants.primaryColor),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Constants.textColor),
                    onPressed: () {
                      setState(() {
                        tempQuantity++; // Update using the dialog's setState
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: TextStyle(color: Constants.textColor)),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      quantity = tempQuantity; // Update the main widget's state
                    });
                    Navigator.pop(context);
                  },
                  child:
                      Text('OK', style: TextStyle(color: Constants.textColor)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              surface: Constants.secondaryColor,
              primary: Constants.primaryColor, // Header background color
              onPrimary: Constants.secondaryColor, // Header text color
              onSurface: Constants.textColor, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              surface: Constants.secondaryColor,
              primary: Constants.primaryColor, // Header background color
              onPrimary: Constants.secondaryColor, // Header text color
              onSurface: Constants.textColor, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    isDateChanged = true;
    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate!.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    brandController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<AuthController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Constants.secondaryColor,
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: SizedBox(
              // height: height - 20,
              width: width,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Constants.secondaryColor,
                      ),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.,
                          children: [
                            Container(
                              height: height * 0.09,
                              width: width * 0.8,
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: width * 0.8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                bottomLeft:
                                                    Radius.circular(0.0),
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
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Image.asset(
                                          "assets/images/genieLamp.png",
                                          height: 48,
                                          width: 80,
                                          fit: BoxFit.contain,
                                        ),
                                        const Text(
                                          "Ask2Genie",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Jaro',
                                              color: Color(0xFFFFC300),
                                              height: -0.2,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                      width: 25,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Column(
                              children: [
                                Text(
                                  "New Query",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Constants.textColor,
                                      letterSpacing: 5,
                                      fontFamily: GoogleFonts.anta().fontFamily,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "With Ask2Genie Family",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.antic().fontFamily,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 200,
                                  width: width * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              vedio = await Utils
                                                  .pickVideoAndReturnBase64(
                                                      context);
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 90,
                                              decoration: const BoxDecoration(
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
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color(0xFF333333),
                                                        Color(0xFF747474)
                                                      ])),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Video Details",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white,
                                                          wordSpacing: 0,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Image.asset(
                                                        "assets/newImages/Video.png"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (vedio != null) {
                                                await Utils.showVideoDialog(
                                                    context, vedio!, false);
                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  // onTap: () async {
                                                  //   if (vedio != null) {
                                                  //     await Utils
                                                  //         .showVideoDialog(
                                                  //             context,
                                                  //             vedio!,
                                                  //             false);
                                                  //   }
                                                  // },
                                                  child: Container(
                                                    height: 90,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: const Color(
                                                                  0XFFDCDCDC)
                                                              .withOpacity(
                                                                  0.6)),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(16),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                0.0),
                                                        topRight:
                                                            Radius.circular(16),
                                                        bottomRight:
                                                            Radius.circular(16),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        image: vedio == null
                                                            ? null
                                                            : const DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: AssetImage(
                                                                    "assets/newImages/Rectangle 63.png")),
                                                        border: vedio == null
                                                            ? null
                                                            : BorderDirectional(
                                                                bottom: BorderSide(
                                                                    width: 2,
                                                                    color: const Color(
                                                                            0XFFDCDCDC)
                                                                        .withOpacity(
                                                                            0.6))),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16),
                                                                bottomLeft:
                                                                    Radius
                                                                        .circular(
                                                                            0.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        16)),
                                                      ),
                                                      child: vedio != null
                                                          ? null
                                                          : Center(
                                                              child: Text(
                                                                "No\nVideo",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily: GoogleFonts
                                                                          .anta()
                                                                      .fontFamily,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  child: Image.asset(
                                                      height: 30,
                                                      width: 30,
                                                      "assets/newImages/Play.png"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 90,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await _showQuantityDialog(
                                                            context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 22,
                                                        // width: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          quantity.toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Qty',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomCheckBox(
                                                      value: isNewChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isNewChecked = value!;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'New',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomCheckBox(
                                                      value: isUsedChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isUsedChecked =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Used',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontSize: 9),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              audio = await Utils
                                                  .recordAudioAndReturnBase64(
                                                      context);
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 90,
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
                                                  bottomLeft:
                                                      Radius.circular(0.0),
                                                  topRight: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xFF333333),
                                                      Color(0xFF747474)
                                                    ]),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Audio Details",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white,
                                                          wordSpacing: 0,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Image.asset(
                                                        "assets/newImages/microphone.png"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (audio != null) {
                                                    await Utils
                                                        .playBase64AudioWithControls(
                                                            context,
                                                            audio!,
                                                            false);
                                                  }
                                                },
                                                child: Container(
                                                  height: 90,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: const Color(
                                                                0XFFDCDCDC)
                                                            .withOpacity(0.6)),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(16),
                                                      bottomLeft:
                                                          Radius.circular(0.0),
                                                      topRight:
                                                          Radius.circular(16),
                                                      bottomRight:
                                                          Radius.circular(16),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      image: audio == null
                                                          ? null
                                                          : const DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                  "assets/newImages/Rectangle 63.png")),
                                                      border: audio == null
                                                          ? null
                                                          : BorderDirectional(
                                                              bottom: BorderSide(
                                                                  width: 2,
                                                                  color: const Color(
                                                                          0XFFDCDCDC)
                                                                      .withOpacity(
                                                                          0.6))),
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft:
                                                                  Radius
                                                                      .circular(
                                                                          16),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      0.0),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          16),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      16)),
                                                    ),
                                                    child: audio != null
                                                        ? null
                                                        : Center(
                                                            child: Text(
                                                              "No\nAudio",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily: GoogleFonts
                                                                        .anta()
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
                                          ),
                                          Container(
                                            height: 50,
                                            width: 90,
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  child: Text(
                                                    'Alternate Product',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            GoogleFonts.anta()
                                                                .fontFamily,
                                                        fontSize: 9),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                CustomCheckBox(
                                                  value: isAlternateChecked,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isAlternateChecked =
                                                          value!;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              List<String> imageList =
                                                  await Utils
                                                      .pickImagesAndReturnBase64(
                                                          context);
                                              images.addAll(imageList);
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 90,
                                              decoration: const BoxDecoration(
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
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color(0xFF333333),
                                                        Color(0xFF747474)
                                                      ])),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Product Images",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white,
                                                          wordSpacing: 0,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Image.asset(
                                                        "assets/newImages/921053786c88f1b63f7fc56df658a41b.png"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: const Color(0XFFDCDCDC)
                                                      .withOpacity(0.6)),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                topRight: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16),
                                              ),
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(16),
                                                    bottomRight:
                                                        Radius.circular(16)),
                                              ),
                                              child: images.isEmpty
                                                  ? Center(
                                                      child: Text(
                                                        "No\nImage",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              GoogleFonts.anta()
                                                                  .fontFamily,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: ImageGallery(
                                                        images: images,
                                                        isMemoryImage: true,
                                                        isOpen: false,
                                                        deleteable: true,
                                                        imageHeight: 32,
                                                        imageWidth: 32,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 90,
                                            child: Column(
                                              children: [
                                                Text(
                                                  DateFormat('EEE dd MMM yyyy')
                                                      .format(selectedDateTime),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          GoogleFonts.anta()
                                                              .fontFamily,
                                                      fontSize: 8),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: _selectDateTime,
                                                      child: Image.asset(
                                                          height: 20,
                                                          width: 20,
                                                          color: isDateChanged
                                                              ? Colors.white
                                                              : Constants
                                                                  .primaryColor,
                                                          "assets/newImages/Schedule.png"),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          DateFormat('hh:mm a')
                                                              .format(
                                                                  selectedDateTime),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  GoogleFonts
                                                                          .anta()
                                                                      .fontFamily,
                                                              fontSize: 8),
                                                        ),
                                                        Text(
                                                          'Valid Till',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  GoogleFonts
                                                                          .anta()
                                                                      .fontFamily,
                                                              fontSize: 8),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Product Name *",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                GoogleFonts.antic().fontFamily,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 35,
                                      width: width * 0.8,
                                      child: InputField(
                                        hintText: "Please, Product Name *",
                                        icon:
                                            "assets/newImages/Dog Tag (1).png",
                                        obscureText: false,
                                        controller: nameController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Product Brand *",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                GoogleFonts.antic().fontFamily,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 35,
                                      width: width * 0.8,
                                      child: InputField(
                                        hintText: "Product Brand *",
                                        icon:
                                            "assets/newImages/Trademark (1).png",
                                        obscureText: false,
                                        controller: brandController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Product Category *",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                GoogleFonts.antic().fontFamily,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 35,
                                      width: width * 0.8,
                                      child: StyledDropdown(
                                        hintText: "Product Category *",
                                        // selectedItems: selectedCatagoryList,
                                        value: selectedCatagoryList,
                                        icon:
                                            "assets/newImages/54ff8ef8cd487959d7f1f35380e8d1c7.png",
                                        items: controller
                                            .catagoriesList.listdata!
                                            .toList(),
                                        itemLabelBuilder: (p0) =>
                                            p0.categoryName!,
                                        onChanged: (value) {
                                          selectedCatagoryList = value;
                                          catagoryController.text =
                                              selectedCatagoryList!
                                                  .categoryName!;
                                          // .map((e) => e.categoryName)
                                          // .join(", ");
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Product Description",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                GoogleFonts.antic().fontFamily,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 45,
                                      width: width * 0.8,
                                      child: InputField(
                                        hintText: "Product Description",
                                        icon:
                                            "assets/newImages/Playlist (1).png",
                                        obscureText: false,
                                        expands: true,
                                        enable: true,
                                        controller: descriptionController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: width * 0.8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Hope ! Genie will find solution soon",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          GoogleFonts.antic()
                                                              .fontFamily,
                                                      fontSize: 11.0,
                                                      wordSpacing: 1,
                                                      letterSpacing: 1.5,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "I hope and Wish you strengthen Ask2Genie family",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily:
                                                          GoogleFonts.antic()
                                                              .fontFamily,
                                                      wordSpacing: 1,
                                                      fontSize: 9.0,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (!isDateChanged) {
                                                  isDateChanged = await Utils
                                                      .showConfirmationDialog(
                                                          context,
                                                          selectedDateTime);
                                                }
                                                if (isDateChanged) {
                                                  if (images.isNotEmpty ||
                                                      vedio != null ||
                                                      audio != null) {
                                                    if (isNewChecked ||
                                                        isUsedChecked ||
                                                        isAlternateChecked) {
                                                      if (nameController
                                                              .text.isNotEmpty &&
                                                          brandController.text
                                                              .isNotEmpty &&
                                                          selectedCatagoryList !=
                                                              null) {
                                                        final controller = Provider
                                                            .of<QueryController>(
                                                                context,
                                                                listen: false);
                                                        Utils.showLoadingDialog(
                                                            context);
                                                        await controller
                                                            .addNewQuery(
                                                          context,
                                                          brand: brandController
                                                              .text,
                                                          buyerID:
                                                              await GetStorage()
                                                                  .read(
                                                                      'buyerID'),
                                                          catID:
                                                              selectedCatagoryList!
                                                                  .categoryID!,
                                                          catName:
                                                              selectedCatagoryList!
                                                                  .categoryName!,
                                                          dueDateTime:
                                                              selectedDateTime
                                                                  .toString(),
                                                          isAlternateCheck:
                                                              isAlternateChecked
                                                                  ? 1
                                                                  : 0,
                                                          isNewChecked:
                                                              isNewChecked
                                                                  ? 1
                                                                  : 0,
                                                          isUsedChecked:
                                                              isUsedChecked
                                                                  ? 1
                                                                  : 0,
                                                          name: nameController
                                                              .text,
                                                          qty: quantity,
                                                          req:
                                                              descriptionController
                                                                  .text,
                                                          uploadImages: images,
                                                          uploadAudio:
                                                              audio ?? "",
                                                          uploadVedio:
                                                              vedio ?? "",
                                                        );
                                                      } else {
                                                        Utils.showCustomSnackbar(
                                                            context: context,
                                                            title: "Error",
                                                            message:
                                                                "Please enter all required * information",
                                                            backgroundColor:
                                                                Colors.grey);
                                                        print(
                                                            "Validation Error");
                                                      }
                                                    } else {
                                                      Utils.showCustomSnackbar(
                                                          context: context,
                                                          title: "Error",
                                                          message:
                                                              "Please select atleast one condition of product",
                                                          backgroundColor:
                                                              Colors.grey);
                                                      print("Validation Error");
                                                    }
                                                  } else {
                                                    Utils.showCustomSnackbar(
                                                        context: context,
                                                        title: "Error",
                                                        message:
                                                            "Please select atleast one media file",
                                                        backgroundColor:
                                                            Colors.grey);
                                                    print("Validation Error");
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 120,
                                                decoration: const BoxDecoration(
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
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(0.0),
                                                      topRight:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    ),
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Color(0xFF333333),
                                                          Color(0xFF747474)
                                                        ])),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Add Query",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            wordSpacing: 2,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .anta()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Image.asset(
                                                          "assets/newImages/mdi_register.png"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                // FootterWidget(
                                //   height: height,
                                //   width: width,
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
