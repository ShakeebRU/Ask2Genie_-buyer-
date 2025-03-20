import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final String icon;
  final bool obscureText;
  final bool enable;
  final bool expands;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String?)? validator;

  const InputField(
      {super.key,
      required this.hintText,
      required this.icon,
      this.keyboardType = TextInputType.emailAddress,
      this.obscureText = false,
      this.enable = true,
      this.expands = false,
      this.validator,
      required this.controller});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Constants.secondaryColor, width: 0, strokeAlign: 0),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator as String? Function(String?)?,
        enabled: widget.enable,
        expands: widget.expands,
        maxLines: widget.expands ? null : 1,
        minLines: widget.expands ? null : 1,
        style: TextStyle(
            fontSize: 13,
            fontFamily: GoogleFonts.antic().fontFamily,
            color: Colors.black),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: widget.controller.text == ""
                  ? Colors.grey
                  : Constants.primaryColor,
              fontSize: 13,
              fontFamily: GoogleFonts.antic().fontFamily),
          border: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.red, width: 1, strokeAlign: 0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.blue, width: 1, strokeAlign: 0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          disabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.white, width: 1, strokeAlign: 0.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.red, width: 1, strokeAlign: 0.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 12.0),
          suffixIcon: SizedBox(
            width: 35,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF333333), Color(0xFF747474)]),
                  border: Border.all(color: const Color(0xFF333333), width: 0),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  widget.icon,
                  height: 40,
                  width: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
