import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../../controllers/auth/verificaiton_controller.dart';
import '../../../utils/constants.dart';
import '../../components/fotter_widget.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  final bool checkRouteLoginExist;
  const OtpScreen({super.key, required this.checkRouteLoginExist});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    getOtp();

    /// In case you need an SMS autofill feature
    smsRetriever = SmsRetrieverImpl(SmartAuth.instance);
  }

  void getOtp() async {
    pinController.text = await GetStorage().read("VerificationCode");
    print("Verification ${pinController.text}");
    setState(() {});
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const focusedBorderColor = Colors.blue;
    const fillColor = Colors.white;
    const borderColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8)),
        border: Border.all(color: borderColor),
      ),
    );

    return SafeArea(
      child: Scaffold(
          backgroundColor: Constants.secondaryColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: height - 20,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                                      if (widget.checkRouteLoginExist) {
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const LoginScreen();
                                        }));
                                      }
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 20,
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
                            height: 30,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "VERIFY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Constants.textColor,
                                          letterSpacing: 5,
                                          fontFamily:
                                              GoogleFonts.anta().fontFamily,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "To Explore the new horizon",
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
                                  children: [
                                    Container(
                                      width: width * 0.6,
                                      child: Row(
                                        children: [
                                          Container(
                                            // color: Colors.white,
                                            margin:
                                                const EdgeInsets.only(left: 2),
                                            child: Text(
                                              "Please, Enter OTP",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily:
                                                      GoogleFonts.antic()
                                                          .fontFamily,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Pinput(
                                              smsRetriever: smsRetriever,
                                              controller: pinController,
                                              focusNode: focusNode,
                                              defaultPinTheme:
                                                  defaultPinTheme.copyWith(
                                                decoration: defaultPinTheme
                                                    .decoration!
                                                    .copyWith(
                                                  color: fillColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(0),
                                                          bottomRight: Radius
                                                              .circular(8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8)),
                                                  border: Border.all(
                                                      color:
                                                          focusedBorderColor),
                                                ),
                                              ),
                                              separatorBuilder: (index) =>
                                                  const SizedBox(width: 9),
                                              validator: (value) {
                                                return value ==
                                                            pinController
                                                                .text ||
                                                        value == ''
                                                    ? null
                                                    : 'Pin is incorrect';
                                              },
                                              hapticFeedbackType:
                                                  HapticFeedbackType
                                                      .lightImpact,
                                              onCompleted: (pin) {
                                                debugPrint('onCompleted: $pin');
                                              },
                                              onChanged: (value) async {
                                                debugPrint('onChanged: $value');
                                                if (value.length == 4) {
                                                  final controller = Provider
                                                      .of<VerificationController>(
                                                          context,
                                                          listen: false);
                                                  await controller.verify(
                                                      context,
                                                      await GetStorage()
                                                          .read("buyerID"),
                                                      pinController.text);
                                                }
                                              },
                                              cursor: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 9),
                                                    width: 22,
                                                    height: 1,
                                                    color: focusedBorderColor,
                                                  ),
                                                ],
                                              ),
                                              focusedPinTheme:
                                                  defaultPinTheme.copyWith(
                                                decoration: defaultPinTheme
                                                    .decoration!
                                                    .copyWith(
                                                  color: fillColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(0),
                                                          bottomRight: Radius
                                                              .circular(8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8)),
                                                  border: Border.all(
                                                      color:
                                                          focusedBorderColor),
                                                ),
                                              ),
                                              submittedPinTheme:
                                                  defaultPinTheme.copyWith(
                                                decoration: defaultPinTheme
                                                    .decoration!
                                                    .copyWith(
                                                  color: fillColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(0),
                                                          bottomRight: Radius
                                                              .circular(8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8)),
                                                  border: Border.all(
                                                      color: borderColor),
                                                ),
                                              ),
                                              errorPinTheme:
                                                  defaultPinTheme.copyWith(
                                                decoration: defaultPinTheme
                                                    .decoration!
                                                    .copyWith(
                                                  color: fillColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(0),
                                                          bottomRight: Radius
                                                              .circular(8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8)),
                                                  border: Border.all(
                                                      color: Colors.redAccent),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: width * 0.6,
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final controller =
                                          Provider.of<VerificationController>(
                                              context,
                                              listen: false);
                                      await controller.verify(
                                          context,
                                          await GetStorage().read("buyerID"),
                                          pinController.text);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Login",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  wordSpacing: 2,
                                                  fontFamily: GoogleFonts.anta()
                                                      .fontFamily,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            child: Image.asset(
                                                "assets/newImages/Group.png"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // const SizedBox(height: 30),
                                Image.asset(
                                    width: width,
                                    height: height * 0.3,
                                    "assets/newImages/Security guard.png"),
                                // const SizedBox(height: 30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Welcome back, We were missing you ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily:
                                              GoogleFonts.antic().fontFamily,
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  FootterWidget(
                    height: height,
                    width: width,
                  )
                ],
              ),
            ),
          )),
    );
    // SafeArea(
    //   child: Scaffold(
    //       backgroundColor: const Color(0xFF079EF6),
    //       body: SingleChildScrollView(
    //         child: SizedBox(
    //           height: height - 30,
    //           width: width,
    //           child: Column(
    //             children: [
    //               Container(
    //                 height: height * 0.14,
    //                 width: width,
    //                 padding: const EdgeInsets.all(5),
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     GestureDetector(
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: const Icon(Icons.arrow_back_ios_new)),
    //                     Column(
    //                       children: [
    //                         const SizedBox(
    //                           height: 10,
    //                         ),
    //                         Image.asset(
    //                           "assets/images/genieLamp.png",
    //                           height: 60,
    //                           width: 80,
    //                           fit: BoxFit.contain,
    //                         ),
    //                         const Text(
    //                           "Ask2Genie",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                               fontSize: 20,
    //                               fontFamily: 'Jaro',
    //                               color: Color(0xFFFFC300),
    //                               height: -0.2,
    //                               fontWeight: FontWeight.w400),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(
    //                       width: 30,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                   child: Container(
    //                 width: width,
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   color: Color.fromARGB(255, 226, 242, 255),
    //                 ),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     const SizedBox(
    //                       height: 2,
    //                     ),
    //                     Column(
    //                       children: [
    //                         Text(
    //                           "VERIFY",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                               fontSize: 22,
    //                               color: Colors.black,
    //                               letterSpacing: 5,
    //                               fontFamily: GoogleFonts.anta().fontFamily,
    //                               fontWeight: FontWeight.w400),
    //                         ),
    //                         Text(
    //                           "To Explore the new horizon",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                               fontSize: 12,
    //                               color: const Color(0xFF505050),
    //                               fontFamily: GoogleFonts.antic().fontFamily,
    //                               fontWeight: FontWeight.w400),
    //                         ),
    //                       ],
    //                     ),
    //                     Container(
    //                       width: width * 0.65,
    //                       child: Row(
    //                         children: [
    //                           Container(
    //                             color: Colors.white,
    //                             child: Text(
    //                               "Please, Enter OTP",
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                   fontSize: 12,
    //                                   color: const Color(0xFF505050),
    //                                   fontFamily:
    //                                       GoogleFonts.antic().fontFamily,
    //                                   fontWeight: FontWeight.w400),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Form(
    //                       key: formKey,
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Directionality(
    //                             textDirection: TextDirection.ltr,
    //                             child: Pinput(
    //                               smsRetriever: smsRetriever,
    //                               controller: pinController,
    //                               focusNode: focusNode,
    //                               defaultPinTheme: defaultPinTheme.copyWith(
    //                                 decoration:
    //                                     defaultPinTheme.decoration!.copyWith(
    //                                   color: fillColor,
    //                                   borderRadius: BorderRadius.circular(19),
    //                                   border:
    //                                       Border.all(color: focusedBorderColor),
    //                                 ),
    //                               ),
    //                               separatorBuilder: (index) =>
    //                                   const SizedBox(width: 8),
    //                               validator: (value) {
    //                                 return value == '2222' || value == ''
    //                                     ? null
    //                                     : 'Pin is incorrect';
    //                               },
    //                               hapticFeedbackType:
    //                                   HapticFeedbackType.lightImpact,
    //                               onCompleted: (pin) {
    //                                 debugPrint('onCompleted: $pin');
    //                               },
    //                               onChanged: (value) {
    //                                 debugPrint('onChanged: $value');
    //                               },
    //                               cursor: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.end,
    //                                 children: [
    //                                   Container(
    //                                     margin:
    //                                         const EdgeInsets.only(bottom: 9),
    //                                     width: 22,
    //                                     height: 1,
    //                                     color: focusedBorderColor,
    //                                   ),
    //                                 ],
    //                               ),
    //                               focusedPinTheme: defaultPinTheme.copyWith(
    //                                 decoration:
    //                                     defaultPinTheme.decoration!.copyWith(
    //                                   color: fillColor,
    //                                   borderRadius: BorderRadius.circular(19),
    //                                   border:
    //                                       Border.all(color: focusedBorderColor),
    //                                 ),
    //                               ),
    //                               submittedPinTheme: defaultPinTheme.copyWith(
    //                                 decoration:
    //                                     defaultPinTheme.decoration!.copyWith(
    //                                   color: fillColor,
    //                                   borderRadius: BorderRadius.circular(19),
    //                                   border: Border.all(color: borderColor),
    //                                 ),
    //                               ),
    //                               errorPinTheme: defaultPinTheme.copyWith(
    //                                 decoration:
    //                                     defaultPinTheme.decoration!.copyWith(
    //                                   color: fillColor,
    //                                   borderRadius: BorderRadius.circular(19),
    //                                   border:
    //                                       Border.all(color: Colors.redAccent),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           // TextButton(
    //                           //   onPressed: () {
    //                           //     focusNode.unfocus();
    //                           //     formKey.currentState!.validate();
    //                           //   },
    //                           //   child: const Text('Validate'),
    //                           // ),
    //                         ],
    //                       ),
    //                     ),
    //                     // OtpTextField(
    //                     //   numberOfFields: 4,
    //                     //   fieldHeight: 50,
    //                     //   fieldWidth: 50,
    //                     //   margin: const EdgeInsets.all(5),
    //                     //   contentPadding: const EdgeInsets.all(2),
    //                     //   cursorColor: Colors.blue,
    //                     //   hasCustomInputDecoration: false,
    //                     //   borderColor: Colors.grey,
    //                     //   focusedBorderColor: Colors.blue,
    //                     //   keyboardType: const TextInputType.numberWithOptions(
    //                     //       decimal: false),
    //                     //   decoration: const InputDecoration(
    //                     //     border: OutlineInputBorder(
    //                     //         borderSide: BorderSide(color: Colors.grey)),
    //                     //   ),
    //                     //   clearText: true,
    //                     //   showFieldAsBox: true,
    //                     //   textStyle: const TextStyle(
    //                     //       color: Colors.black, fontSize: 18),
    //                     //   onCodeChanged: (String value) {},
    //                     //   handleControllers: (controllers) {
    //                     //     controls = controllers;
    //                     //   },
    //                     //   onSubmit: (String verificationCode) {},
    //                     // ),
    //                     SizedBox(
    //                       width: width * 0.8,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                           Container(
    //                             height: 30,
    //                             width: 100,
    //                             decoration: const BoxDecoration(
    //                               gradient: LinearGradient(
    //                                   begin: Alignment.topCenter,
    //                                   end: Alignment.bottomCenter,
    //                                   colors: [
    //                                     Color(0xFF079EF6),
    //                                     Color(0xFF045C90)
    //                                   ]),
    //                               borderRadius: const BorderRadius.only(
    //                                 topLeft: Radius.circular(8.0),
    //                                 bottomLeft: Radius.circular(0.0),
    //                                 bottomRight: Radius.circular(8.0),
    //                                 topRight: Radius.circular(8.0),
    //                               ),
    //                             ),
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.end,
    //                               children: [
    //                                 Expanded(
    //                                   child: Container(
    //                                     height: 30,
    //                                     decoration: const BoxDecoration(
    //                                         borderRadius: BorderRadius.only(
    //                                           topLeft: Radius.circular(8),
    //                                           bottomLeft: Radius.circular(0.0),
    //                                           topRight: Radius.circular(2),
    //                                           bottomRight: Radius.circular(2),
    //                                         ),
    //                                         gradient: LinearGradient(
    //                                             begin: Alignment.topCenter,
    //                                             end: Alignment.bottomCenter,
    //                                             colors: [
    //                                               Color(0xFFFFD54B),
    //                                               Color(0xFF7F6204)
    //                                             ])),
    //                                     child: Center(
    //                                       child: Text(
    //                                         "Login",
    //                                         textAlign: TextAlign.center,
    //                                         style: TextStyle(
    //                                             fontSize: 15,
    //                                             color: Colors.white,
    //                                             wordSpacing: 2,
    //                                             // height: -0.2,
    //                                             fontFamily: GoogleFonts.anta()
    //                                                 .fontFamily,
    //                                             fontWeight: FontWeight.w400),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 const SizedBox(
    //                                   height: 40,
    //                                   width: 25,
    //                                   child: Icon(
    //                                     Icons.login,
    //                                     size: 20,
    //                                     color: Color(0xFFFFD54B),
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Image.asset(
    //                         width: width,
    //                         height: height * 0.3,
    //                         "assets/images/welcomingRobot.png"),
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       children: [
    //                         Text(
    //                           "Welcome back, We were missing you",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 12.0,
    //                             fontFamily: GoogleFonts.antic().fontFamily,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         const SizedBox(height: 10.0),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               )),
    //               SizedBox(
    //                 height: height * 0.13,
    //                 width: width,
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(left: 25.0),
    //                   child: Center(
    //                     child: Image.asset(
    //                       "assets/images/QuestSolutions2.png",
    //                       height: 80,
    //                       fit: BoxFit.contain,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )),
    // );
  }
}

/// You, as a developer should implement this interface.
/// You can use any package to retrieve the SMS code. in this example we are using SmartAuth
class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsRetrieverApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: $signature');
    final res = await smartAuth.getSmsWithRetrieverApi();
    if (res.data != null && res.data?.code != null) {
      return res.data!.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
