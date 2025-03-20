import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';
import '../../utils/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServicesVar = SplashServices();
  @override
  void initState() {
    splashServicesVar.islogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Constants.primaryColor,
            body: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height * 0.2,
                    width: width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "By",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.anta().fontFamily,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Text(
                          "Questech Solutions",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              letterSpacing: 5,
                              fontFamily: GoogleFonts.anta().fontFamily,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.43,
                    width: width,
                    child: Image.asset("assets/newImages/genieLamp.png"),
                  ),
                  Container(
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: const Color(0xFF333333)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.6,
                          child: Divider(
                            color: Constants.primaryColor,
                            height: 5,
                            thickness: 5,
                          ),
                        ),
                        Image.asset(
                            width: width * 0.6,
                            "assets/newImages/Ask2Genie.png"),
                      ],
                    ),
                  ),
                ],
              ),
            )));
    // SafeArea(
    //   child: Scaffold(
    //       backgroundColor: const Color.fromARGB(255, 226, 242, 255),
    //       body: SizedBox(
    //         height: height - 30,
    //         width: width,
    //         child: Column(
    //           children: [
    //             Container(
    //               height: height * 0.14,
    //               width: width,
    //               padding: const EdgeInsets.all(5),
    //               child: const Center(
    //                 child: Text(
    //                   "Since 2001",
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontSize: 34,
    //                       fontFamily: 'Jaro',
    //                       fontWeight: FontWeight.w400),
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //                 child: Container(
    //               width: width,
    //               decoration: const BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(10)),
    //                 color: Color(0xFF079EF6),
    //               ),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 50,
    //                   ),
    //                   Image.asset(
    //                     "assets/images/genieLamp.png",
    //                     height: 350,
    //                     width: width * 0.9,
    //                     fit: BoxFit.contain,
    //                   ),
    //                   const Text(
    //                     "Ask2Genie",
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                         fontSize: 64,
    //                         fontFamily: 'Jaro',
    //                         color: Color(0xFFFFC300),
    //                         height: -0.2,
    //                         fontWeight: FontWeight.w400),
    //                   ),
    //                 ],
    //               ),
    //             )),
    //             SizedBox(
    //                 height: height * 0.13,
    //                 width: width,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Image.asset(
    //                       "assets/images/Lion.png",
    //                       height: 70,
    //                       width: 70,
    //                       fit: BoxFit.contain,
    //                     ),
    //                     Image.asset(
    //                       "assets/images/QuestechSolutions.png",
    //                       height: 80,
    //                       width: 80,
    //                       fit: BoxFit.contain,
    //                     ),
    //                     const SizedBox(
    //                       width: 25,
    //                     )
    //                   ],
    //                 )),
    //           ],
    //         ),
    //       )),
    // );
  }
}
