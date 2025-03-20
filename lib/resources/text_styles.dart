import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KTextStyles {
  static TextStyle title(Color color) {
    return GoogleFonts.ubuntu(
      fontWeight: FontWeight.w500,
      fontSize: 22,
      color: color,
    );
  }

  static TextStyle heading(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: color,
      );

  static TextStyle subheading(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: color,
      );
  static TextStyle subtitle(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: color,
      );
  static TextStyle label(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: color,
      );
  static TextStyle caption(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: color,
      );
  static TextStyle bodytext(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: color,
      );
  static TextStyle mutedtext(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.normal,
        fontSize: 10,
        color: color,
      );
  static TextStyle home(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w300,
        fontSize: 27,
        color: color,
      );
  static TextStyle home1(Color color) => GoogleFonts.ubuntu(
        fontWeight: FontWeight.w700,
        fontSize: 27,
        color: color,
      );
  static TextStyle urdu(Color color) => GoogleFonts.elMessiri(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: color,
      );
  static TextStyle urdubody(Color color) => GoogleFonts.elMessiri(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: color,
      );
  static TextStyle urduBold(Color color) => GoogleFonts.elMessiri(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: color,
      );
}
