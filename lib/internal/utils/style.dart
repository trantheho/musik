import 'package:flutter/material.dart';

class AppTextStyle{
  static const TextStyle montserrat = TextStyle(
    fontWeight: FontWeight.w400,
  );

  static TextStyle get normal => montserrat.copyWith(fontSize: 14, color: Colors.black);

  static TextStyle get medium => montserrat.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle get bold => montserrat.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700);
}

class AppColors {
  static const Color green = Color.fromRGBO(18, 183, 106, 1);
  static const Color lightYellow = Color.fromRGBO(254, 197, 75, 1);
  static const Color orange = Color.fromRGBO(230, 127, 30, 1);
  static const Color grey = Color.fromRGBO(156, 159, 158, 1);
  static const Color pink = Color.fromRGBO(255, 46, 108, 1);
  static const Color purple = Color.fromRGBO(122, 30, 118, 1);
  static const Color greyLight = Color.fromRGBO(124, 124, 124, 1);
  static const Color greyBold = Color.fromRGBO(137, 137, 137, 1);
  static const Color greyWhite = Color.fromRGBO(240, 240, 240, 1);
  static const Color grey177 = Color.fromRGBO(177, 177, 177, 1);
  static const Color lightGrey = Color.fromRGBO(242, 242, 242, 1);
  static const Color whiteGrey = Color.fromRGBO(240, 240, 240, 1);
  static const Color grey170 = Color.fromRGBO(170, 170, 170, 1);
}