import 'package:flutter/material.dart';


class Style {
  static const String primaryFont = 'Roboto';
  
  static const Color primaryColor = Color(0xFF363636);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color infoColor = Color(0xFF3A73EF);
  static const Color successColor = Color(0xFF84CC16);
  static const Color warningColor = Color(0xFFFAD12C);
  static const Color dangerColor = Color(0xFFDC2626);

  static const BoxShadow primaryShadow = BoxShadow(
    color: Color(0xFF757575),
    spreadRadius: 1.0,
    blurRadius: 15.0,
    blurStyle: BlurStyle.outer
  );

  static const Radius primaryRadius = Radius.circular(6.0);

  static const EdgeInsets primaryPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 15
  );
  static const EdgeInsets secondaryPadding = EdgeInsets.symmetric(
    horizontal: 40,
    vertical: 30
  );

  static const EdgeInsets primaryBottomMargin = EdgeInsets.only(
    bottom: 20.0
  );
  static const EdgeInsets secondaryBottomMargin = EdgeInsets.only(
    bottom: 10.0
  );
  static const EdgeInsets tertiaryBottomMargin = EdgeInsets.only(
    bottom: 60.0
  );
}
