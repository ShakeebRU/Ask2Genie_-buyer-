import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';
import 'notification_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  // List of screens to display based on selected bottom nav item
  final List<Widget> _screens = [
    const NotificationScreen(),
    const Center(child: Text("Chat", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Setting", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Contact", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     spreadRadius: 5,
          //     blurRadius: 10,
          //   ),
          // ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Constants.primaryColor,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            iconSize: 40,
            selectedLabelStyle: TextStyle(
                fontFamily: GoogleFonts.akatab().fontFamily,
                color: Constants.secondaryColor,
                fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(
                fontFamily: GoogleFonts.akatab().fontFamily,
                color: Constants.secondaryColor,
                fontWeight: FontWeight.w700),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Constants.primaryColor,
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/newImages/30b9853fdfa0aefc978bf98289087c9f.png"))),
                ),
                label: "Notifications",
              ),
              BottomNavigationBarItem(
                backgroundColor: Constants.primaryColor,
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/newImages/00aeaf9d15b7d16f018192c66f1d9c5d.png"))),
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                backgroundColor: Constants.primaryColor,
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/newImages/384766dfc38176002df7714cf0012e9c.png"))),
                ),
                label: "Setting",
              ),
              BottomNavigationBarItem(
                backgroundColor: Constants.primaryColor,
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/newImages/6bcbd214d98e330e8ca6fe176e9b4e6f.png"))),
                ),
                label: "Contact",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
