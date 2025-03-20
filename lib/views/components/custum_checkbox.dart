import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color color;
  final double height;
  final double width;

  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.height = 22,
    this.width = 22,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        height: height,
        width: width,
        // margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
          color: Colors.transparent, // Transparent internal color
        ),
        // decoration: BoxDecoration(
        //   shape: BoxShape.rectangle,
        //   border: Border.all(
        //     color: Colors.white, // White border color
        //     width: 2,
        //   ),
        // ),
        child: value
            ? Icon(
                Icons.check,
                color: color,
                size:
                    height == 22 ? 16 : 20, // Adjust the size of the check icon
              )
            : null, // No icon if not checked
      ),
    );
  }
}
