import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import '../../components/fotter_widget.dart';
import '../../components/input_field_widget.dart';
import 'reset_password_screen.dart';

class ResetPasswordRequestScreen extends StatefulWidget {
  const ResetPasswordRequestScreen({super.key});

  @override
  State<ResetPasswordRequestScreen> createState() =>
      _ResetPasswordRequestScreenState();
}

class _ResetPasswordRequestScreenState
    extends State<ResetPasswordRequestScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                                      "ReSet Password",
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
                                      "For your security, we have sent you an email",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mobile Number",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily:
                                                GoogleFonts.antic().fontFamily,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 40,
                                      width: width * 0.8,
                                      child: InputField(
                                        hintText:
                                            "Please, Enter your Mobile Number",
                                        icon:
                                            "assets/newImages/1c390f706d79f8081dc90111d827e726.png",
                                        obscureText: false,
                                        controller: emailController,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: width * 0.8,
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const ResetPasswordScreen();
                                      }));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 150,
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
                                              "Send Request",
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
                                                "assets/newImages/fluent-mdl2_message-friend-request.png"),
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
                                    "assets/newImages/Handsphone.png"),
                                // const SizedBox(height: 30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Please, Join with our Genie to explore the world",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily:
                                            GoogleFonts.antic().fontFamily,
                                        color: Colors.white,
                                      ),
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
  }
}
