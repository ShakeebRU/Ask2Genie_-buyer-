import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class FootterWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool light;
  const FootterWidget(
      {super.key,
      required this.height,
      required this.width,
      this.light = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: light ? Constants.secondaryColor : Constants.primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width * 0.4,
            child: Divider(
              color: light ? Constants.primaryColor : Constants.secondaryColor,
              height: 2,
              thickness: 3,
            ),
          ),
          Image.asset(
              width: width * 0.3,
              light
                  ? "assets/newImages/Ask2Genie.png"
                  : "assets/newImages/Ask2Genie2.png"),
        ],
      ),
    );
  }
}
