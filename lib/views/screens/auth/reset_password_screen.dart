import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import '../../components/fotter_widget.dart';
import '../../components/input_field_widget.dart';
import 'otp_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                                      "New Password",
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
                                      "Please Enter your New Password for Re Joining the Family",
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
                                // const SizedBox(
                                //   height: 30,
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("New Password",
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
                                            "Please, Enter your New Password",
                                        icon:
                                            "assets/newImages/Show Password.png",
                                        obscureText: false,
                                        controller: passwordController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text("Re-Enter New Password",
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
                                            "Please, Re-Enter your New Password",
                                        icon: "assets/newImages/Repeat.png",
                                        obscureText: false,
                                        controller: confirmPasswordController,
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(
                                //   height: 30,
                                // ),
                                Container(
                                  width: width * 0.8,
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const OtpScreen(
                                          checkRouteLoginExist: true,
                                        );
                                      }));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 160,
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
                                              "Reset Password",
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
                                                "assets/newImages/Password Reset.png"),
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
                                    "assets/newImages/New house.png"),
                                // const SizedBox(height: 30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Please, Check your Mobile Phone for OTP",
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
  }
}
