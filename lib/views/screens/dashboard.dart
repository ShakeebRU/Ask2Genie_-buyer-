import 'package:flutter/material.dart';
import 'package:genie/views/screens/best_sellers_screen.dart';
import 'package:genie/views/screens/selected_sellers_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/query_controller.dart';
import '../../models/auth/logined_model.dart';
import '../../utils/preferences.dart';
import '../../utils/utils.dart';
import '../components/fotter_widget.dart';
import 'active_query_screen.dart';
import 'auth/login_screen.dart';
import 'history_query_screen.dart';
import 'new_query_screen.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name = "";
  String? image;
  String? about;
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
      about = user.aboutDetail;
    }
    setState(() {});
  }

  List<String> icons = [
    "assets/newImages/Hand with phone and social media icons.png",
    "assets/newImages/Girl reading the fine print on a document.png",
    "assets/newImages/HR reads the resume in the browser.png",
    "assets/newImages/Tablet with credit history showing credit score.png",
    "assets/newImages/Best student.png",
    "assets/newImages/Puzzled man looking at question mark.png",
    "assets/newImages/Modern drip chamber.png",
    "assets/newImages/Woman leaning on a question mark.png",
    "assets/newImages/Woman leaning on a question mark.png",
    "",
  ];

  List<String> labels = [
    "Notifications",
    "New Query",
    "Pending Queries",
    "History Buying",
    "Best Sellers",
    "Selected Sellers",
    "Help",
    "FAQ",
    "Logout",
    ""
  ];

  Future<void> navigation(int index) async {
    final queryController =
        Provider.of<QueryController>(context, listen: false);
    switch (index) {
      case 0:
        Utils.showLoadingDialog(context);
        await queryController
            .getNotificationsList(await GetStorage().read('buyerID'));
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const NotificationScreen();
        }));
        break;
      case 1:
        Utils.showLoadingDialog(context);
        final catagoryController =
            Provider.of<AuthController>(context, listen: false);
        await catagoryController.getCatagoryList();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const NewQueryScreen();
        }));

        break;
      case 2:
        Utils.showLoadingDialog(context);
        await queryController
            .getActiveQueryList(await GetStorage().read('buyerID'));
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ActiveQueryScreen();
        }));
        break;
      case 3:
        Utils.showLoadingDialog(context);
        await queryController
            .getHistoryQueryList(await GetStorage().read('buyerID'));
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HistoryQueryScreen();
        }));
        break;
      case 4:
        Utils.showLoadingDialog(context);
        await queryController.getBestSellersList();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BestSellersScreen(
            sellersList: queryController.bestSellersList,
          );
        }));

        break;
      case 5:
        //selected sellers
        Utils.showLoadingDialog(context);
        await queryController
            .getselectedSellersList(await GetStorage().read('buyerID'));
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SelectedSellersScreen();
        }));

        break;
      case 6:
        break;
      case 7:
        break;
      case 8:
        await Preferences.init().then((onValue) => onValue.deleteCridentials());
        await GetStorage().remove("buyerID");
        await GetStorage().remove("token");
        await GetStorage().remove("accountStatus");
        await GetStorage().remove("name");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }));
        break;
      case 9:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: SizedBox(
          height: height - 20,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header Section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile Image
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: const BorderDirectional(
                            bottom: BorderSide(color: Colors.white, width: 2)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(0),
                        ),
                        image: image != "" && image != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(image!),
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/newImages/testimg.png')),
                      ),
                    ),
                    // User Info
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Constants.secondaryColor,
                                letterSpacing: 1.5,
                                fontFamily: GoogleFonts.anta().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          // Text(
                          //   "Entrepreneur",
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //     color: Constants.secondaryColor,
                          //     letterSpacing: 1,
                          //     fontFamily: GoogleFonts.antic().fontFamily,
                          //   ),
                          // ),
                          const SizedBox(height: 4),
                          Text(
                            "Welcome, How May I Help You",
                            style: TextStyle(
                              fontSize: 12,
                              color: Constants.secondaryColor,
                              fontFamily: GoogleFonts.antic().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Genie Section
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/genieLamp.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Ask2Genie",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Jaro',
                            color: Constants.secondaryColor,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      alignment: WrapAlignment.center,
                      children: List.generate(labels.length, (index) {
                        return GestureDetector(
                          onTap: () async {
                            print("navigate to $index");
                            await navigation(index);
                          },
                          child: Container(
                              height: 130,
                              width: 130,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Constants.secondaryColor,
                                border: const BorderDirectional(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 4)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      offset: const Offset(0, 15),
                                      spreadRadius: 0.6,
                                      color: Colors.black.withOpacity(0.4))
                                ],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  icons[index] == ""
                                      ? const SizedBox(
                                          height: 80,
                                          width: 80,
                                        )
                                      : Image.asset(
                                          height: 80, width: 80, icons[index]),
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      labels[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 1,
                                        fontFamily:
                                            GoogleFonts.akatab().fontFamily,
                                        color: const Color(0xFFFFD54B),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              // Footer Section
              FootterWidget(
                height: height,
                width: width,
                light: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
