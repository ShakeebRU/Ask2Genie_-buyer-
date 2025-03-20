import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../models/auth/category_list_model.dart';
import '../../../models/auth/city_list_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../components/drop_down_multiple.dart';
import '../../components/drop_down_widget.dart';
import '../../components/fotter_widget.dart';
import '../../components/input_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String address = "";
  String latitude = "";
  String longitude = "";
  String image = "";
  CityModel? city;
  List<CategoryListdata> selectedCatagoryList = [];

  var regFormKey = GlobalKey<FormState>();

  bool valiedateEmail(String value) {
    if (value.isEmpty) {
      Utils.showCustomSnackbar(
          context: context,
          title: "Error",
          message: "Please enter your email",
          backgroundColor: Colors.grey);
      return false;
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value)) {
      Utils.showCustomSnackbar(
          context: context,
          title: "Error",
          message: "Please enter valid email",
          backgroundColor: Colors.grey);
      return false;
    }
    return true;
  }

  bool valiedateMobile(String value) {
    if (value.isEmpty) {
      Utils.showCustomSnackbar(
          context: context,
          title: "Error",
          message: "Please enter your mobile number",
          backgroundColor: Colors.grey);
      return false;
    }
    // else if (!RegExp(r'^(?:\+92|0)?3[0-9]{9}$').hasMatch(value)) {
    //   Utils.showCustomSnackbar(
    //       context: context,
    //       title: "Error",
    //       message: "Please enter valid mobile number",
    //       backgroundColor: Colors.grey);
    //   return false;
    // }
    return true;
  }

  loadLocation() async {
    Position? val = await Utils.getGeoLocationPosition().then((value) async {
      address = await Utils.getAddressFromLatLong(value);
    });
    latitude = val?.latitude.toString() ?? "";
    longitude = val?.longitude.toString() ?? "";
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    idController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    companyController.dispose();
    businessController.dispose();
    cityController.dispose();
    aboutController.dispose();
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
              child: SizedBox(
                height: height - 20,
                width: width,
                child: Form(
                  key: regFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // shrinkWrap: true,
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
                              SizedBox(
                                height: 5,
                              ),
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
                                            // margin: const EdgeInsets.only(left: 10),
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
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Register",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Constants.textColor,
                                            letterSpacing: 5,
                                            fontFamily:
                                                GoogleFonts.anta().fontFamily,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      // Text(
                                      //   "With Ask2Genie Family",
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //       fontSize: 11,
                                      //       color: Colors.white,
                                      //       fontFamily:
                                      //           GoogleFonts.antic().fontFamily,
                                      //       fontWeight: FontWeight.w400),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    height: 40,
                                    width: width * 0.8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            border: const BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 1)),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomRight: Radius.circular(0),
                                            ),
                                            image: image != ""
                                                ? DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: MemoryImage(
                                                        base64Decode(image)),
                                                  )
                                                : null,
                                          ),
                                          child: image != ""
                                              ? null
                                              : Image.asset(
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.cover,
                                                  'assets/newImages/testimg.png'),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Utils.pickImage(
                                                    useCamera: false)
                                                .then((value) {
                                              image = value ?? "";
                                              setState(() {});
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 105,
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
                                                    ])),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Gallery Image",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11,
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
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: Image.asset(
                                                      "assets/newImages/1093ae3d00c876a3d1196ee3e108ecf0.png"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Utils.pickImage(
                                                    useCamera: true)
                                                .then((value) {
                                              image = value ?? "";
                                              setState(() {});
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 105,
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
                                                    ])),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Take Photo",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11,
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
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: Image.asset(
                                                      "assets/newImages/921053786c88f1b63f7fc56df658a41b.png"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(
                                      //   width: width * 0.8,
                                      //   child: Text(
                                      //     "Please, Fill the following details: ",
                                      //     textAlign: TextAlign.left,
                                      //     style: TextStyle(
                                      //         fontSize: 11,
                                      //         color: Colors.white,
                                      //         fontFamily:
                                      //             GoogleFonts.antic().fontFamily,
                                      //         fontWeight: FontWeight.w400),
                                      //   ),
                                      // ),
                                      Text("Name *",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: GoogleFonts.antic()
                                                  .fontFamily,
                                              color: Colors.white)),
                                      SizedBox(
                                        height: 45,
                                        width: width * 0.8,
                                        child: InputField(
                                          hintText: "Please, Enter your Name *",
                                          icon:
                                              "assets/newImages/6f695fa8642d6859f21b81fc23d56c11.png",
                                          obscureText: false,
                                          controller: nameController,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Text("Email *",
                                      //     style: TextStyle(
                                      //         fontSize: 11,
                                      //         fontFamily: GoogleFonts.antic()
                                      //             .fontFamily,
                                      //         color: Colors.white)),
                                      // SizedBox(
                                      //   height: 35,
                                      //   width: width * 0.8,
                                      //   child: InputField(
                                      //     hintText: "Your Email *",
                                      //     icon:
                                      //         "assets/newImages/1c390f706d79f8081dc90111d827e726.png",
                                      //     obscureText: false,
                                      //     controller: idController,
                                      //     // validator: Validators.emailValidator,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text("Mobile Number *",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: GoogleFonts.antic()
                                                  .fontFamily,
                                              color: Colors.white)),
                                      SizedBox(
                                        height: 45,
                                        width: width * 0.8,
                                        child: InputField(
                                          hintText: "Your Mobile Number *",
                                          keyboardType: TextInputType.phone,
                                          icon:
                                              "assets/newImages/6a025d1e792c18f734a7a4c58439b977.png",
                                          obscureText: false,
                                          controller: mobileController,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Password *",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: GoogleFonts.antic()
                                                  .fontFamily,
                                              color: Colors.white)),
                                      SizedBox(
                                        height: 45,
                                        width: width * 0.8,
                                        child: InputField(
                                          hintText: "Your Password *",
                                          icon:
                                              "assets/newImages/00a4cee1a3e3612776c53f0a90250bf5.png",
                                          obscureText: true,
                                          controller: passwordController,
                                          // validator: Validators.password,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // Text("Company Name",
                                      //     style: TextStyle(
                                      //         fontSize: 11,
                                      //         fontFamily: GoogleFonts.antic()
                                      //             .fontFamily,
                                      //         color: Colors.white)),
                                      // SizedBox(
                                      //   height: 35,
                                      //   width: width * 0.8,
                                      //   child: InputField(
                                      //     hintText: "Your Company Name",
                                      //     icon:
                                      //         "assets/newImages/255b54364c6a5de35f98ebba10102830.png",
                                      //     obscureText: false,
                                      //     controller: companyController,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Text("Business Type",
                                      //     style: TextStyle(
                                      //         fontSize: 11,
                                      //         fontFamily: GoogleFonts.antic()
                                      //             .fontFamily,
                                      //         color: Colors.white)),
                                      // SizedBox(
                                      //   height: 35,
                                      //   width: width * 0.8,
                                      //   child: StyledDropdownMultiple(
                                      //     hintText: "Business Type",
                                      //     selectedItems: selectedCatagoryList,
                                      //     icon:
                                      //         "assets/newImages/54ff8ef8cd487959d7f1f35380e8d1c7.png",
                                      //     items: controller
                                      //         .catagoriesList.listdata!
                                      //         .toList(),
                                      //     itemLabelBuilder: (p0) =>
                                      //         p0.categoryName!,
                                      //     onChanged: (value) {
                                      //       selectedCatagoryList = value;
                                      //       businessController.text =
                                      //           selectedCatagoryList
                                      //               .map((e) => e.categoryName)
                                      //               .join(", ");
                                      //       setState(() {});
                                      //     },
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Text("City *",
                                      //     style: TextStyle(
                                      //         fontSize: 11,
                                      //         fontFamily: GoogleFonts.antic()
                                      //             .fontFamily,
                                      //         color: Colors.white)),
                                      // SizedBox(
                                      //   height: 35,
                                      //   width: width * 0.8,
                                      //   child: StyledDropdown(
                                      //     hintText: "Your City *",
                                      //     icon:
                                      //         "assets/newImages/54ff8ef8cd487959d7f1f35380e8d1c7.png",
                                      //     items: controller.cityList.listdata!
                                      //         .map((e) => e.cityName)
                                      //         .toList(),
                                      //     onChanged: (value) {
                                      //       city = controller.cityList.listdata!
                                      //           .firstWhere((element) =>
                                      //               element.cityName == value);
                                      //       businessController.text =
                                      //           value.toString();
                                      //       setState(() {});
                                      //     },
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Text("About ",
                                      //     style: TextStyle(
                                      //         fontSize: 11,
                                      //         fontFamily: GoogleFonts.antic()
                                      //             .fontFamily,
                                      //         color: Colors.white)),
                                      // SizedBox(
                                      //   height: 45,
                                      //   width: width * 0.8,
                                      //   child: InputField(
                                      //     hintText: "Special About You",
                                      //     icon:
                                      //         "assets/newImages/ce576248236ced1ed6d2cf9964b21fe5.png",
                                      //     obscureText: false,
                                      //     expands: true,
                                      //     enable: true,
                                      //     controller: aboutController,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                      width: width * 0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                              height: 85,
                                              fit: BoxFit.cover,
                                              "assets/newImages/df4cb4da24fd59e3c4c332f25ebfe7d9.png"),
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
                                                    "Thanks, for Joining Ask2Genie",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            GoogleFonts.antic()
                                                                .fontFamily,
                                                        fontSize: 12.0,
                                                        wordSpacing: 1,
                                                        letterSpacing: 1.5,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "I hope and Wish you strengthen our family",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily:
                                                            GoogleFonts.antic()
                                                                .fontFamily,
                                                        wordSpacing: 1,
                                                        fontSize: 10.0,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (
                                                      // city != null &&
                                                      mobileController.text
                                                              .isNotEmpty &&
                                                          passwordController
                                                              .text
                                                              .isNotEmpty &&
                                                          // idController
                                                          //     .text.isNotEmpty &&
                                                          nameController
                                                              .text.isNotEmpty
                                                      // companyController
                                                      //     .text.isNotEmpty &&
                                                      // businessController
                                                      //     .text.isNotEmpty &&
                                                      // aboutController
                                                      //     .text.isNotEmpty &&
                                                      ) {
                                                    // if (valiedateEmail(
                                                    //         idController
                                                    //             .text) &&
                                                    //     valiedateMobile(
                                                    //         mobileController
                                                    //             .text)) {
                                                    try {
                                                      await controller.register(
                                                          context,
                                                          nameController.text,
                                                          idController.text,
                                                          passwordController
                                                              .text,
                                                          mobileController.text,
                                                          companyController
                                                              .text,
                                                          selectedCatagoryList,
                                                          city,
                                                          aboutController.text,
                                                          address,
                                                          latitude,
                                                          longitude,
                                                          image);
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    // }
                                                  } else {
                                                    Utils.showCustomSnackbar(
                                                        context: context,
                                                        title: "Error",
                                                        message:
                                                            "Please enter all required * information",
                                                        backgroundColor:
                                                            Colors.grey);
                                                    print("Validation Error");
                                                  }
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
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
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
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
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Register",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
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
                                                        margin: const EdgeInsets
                                                            .only(right: 5),
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      FootterWidget(
                        height: height,
                        width: width,
                      )
                    ],
                  ),
                ),
              ),
            )),
      );
    });
  }
}
