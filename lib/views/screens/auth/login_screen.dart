import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../components/fotter_widget.dart';
import '../../components/input_field_widget.dart';
import 'register_screen.dart';
import 'reset_password_request_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                children: [
                  Expanded(
                      child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Constants.secondaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.14,
                          width: width,
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                "assets/images/genieLamp.png",
                                height: 60,
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                              const Text(
                                "Ask2Genie",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Jaro',
                                    color: Color(0xFFFFC300),
                                    height: -0.2,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Constants.textColor,
                                  letterSpacing: 5,
                                  fontFamily: GoogleFonts.anta().fontFamily,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "To Explore Fantasy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Constants.textColor,
                                  fontFamily: GoogleFonts.antic().fontFamily,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mobile Number *",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: GoogleFonts.antic().fontFamily,
                                    color: Colors.white)),
                            SizedBox(
                              height: 45,
                              width: width * 0.8,
                              child: InputField(
                                hintText: "Please, Enter your mobile number",
                                icon: "assets/newImages/ID Verified.png",
                                controller: emailController,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("Password *",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: GoogleFonts.antic().fontFamily,
                                    color: Colors.white)),
                            SizedBox(
                              height: 45,
                              width: width * 0.8,
                              child: InputField(
                                hintText: "Please, Enter Password",
                                icon: "assets/newImages/Password.png",
                                controller: passwordController,
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                        // test
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (emailController.text != "" &&
                                      passwordController.text != "") {
                                    final loginController =
                                        Provider.of<AuthController>(context,
                                            listen: false);
                                    await loginController.login(
                                        context,
                                        emailController.text,
                                        passwordController.text);
                                  } else {
                                    Utils.flushBarErrorMessage(
                                        "Credentials can't be empty", context);
                                  }
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
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              wordSpacing: 2,
                                              fontFamily:
                                                  GoogleFonts.anta().fontFamily,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Container(
                                          height: 20,
                                          width: 20,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: Image.asset(
                                              "assets/newImages/Group.png"))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      height: 100,
                                      width: 100,
                                      "assets/newImages/AI cyber security.png",
                                    ),
                                    Image.asset(
                                      height: 100,
                                      width: 100,
                                      "assets/newImages/Postman and empty website page with tumbleweed.png",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const ResetPasswordRequestScreen();
                                            }));
                                          },
                                          child: Text(
                                            "Forget Password",
                                            style: TextStyle(
                                              color: Constants.textColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.antic()
                                                  .fontFamily,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Don't you worry, just click it",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily:
                                            GoogleFonts.antic().fontFamily,
                                        fontSize: 10.0,
                                        color: Constants.textColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Still not a Member",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Constants.textColor,
                                            fontFamily:
                                                GoogleFonts.antic().fontFamily,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        )
                                        // Image.asset(
                                        //   "assets/images/Registration.png",
                                        //   height: 40,
                                        //   width: 40,
                                        // )
                                      ],
                                    ),
                                    Text(
                                      "Sign Up to explore your wishes",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily:
                                            GoogleFonts.antic().fontFamily,
                                        fontSize: 10.0,
                                        color: Constants.textColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Utils.showLoadingDialog(context);
                                        final controller =
                                            Provider.of<AuthController>(context,
                                                listen: false);
                                        await controller.getCityList();
                                        await controller.getCatagoryList();
                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const RegisterScreen();
                                        }));
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
                                                "Sign Up",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    wordSpacing: 2,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              child: Image.asset(
                                                  "assets/newImages/Group (1).png"),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "OR ",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily:
                                                        GoogleFonts.anta()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w400,
                                                    color: Constants.textColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Image.asset(
                                                    height: 30,
                                                    width: 30,
                                                    "assets/newImages/LinkedIn.png"),
                                                const SizedBox(width: 5.0),
                                                Image.asset(
                                                    height: 35,
                                                    width: 35,
                                                    fit: BoxFit.contain,
                                                    "assets/newImages/Facebook.png"),
                                                const SizedBox(width: 5.0),
                                                Image.asset(
                                                    height: 35,
                                                    width: 35,
                                                    fit: BoxFit.contain,
                                                    "assets/newImages/Gmail Login.png")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5.0),
                        // Footer Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Please, Join with our Genie to explore the world",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: GoogleFonts.antic().fontFamily,
                                color: Constants.textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                      ],
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
