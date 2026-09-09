import 'package:flutter/material.dart';

abstract final class AppTypography {
  static const fontFamily = 'Roboto';

  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const bold = FontWeight.w700;

  static const textTheme = TextTheme(
    displayLarge: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    displayMedium: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    displaySmall: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    headlineLarge: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    headlineMedium: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    headlineSmall: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    titleLarge: TextStyle(fontFamily: fontFamily, fontWeight: bold),
    titleMedium: TextStyle(fontFamily: fontFamily, fontWeight: medium),
    titleSmall: TextStyle(fontFamily: fontFamily, fontWeight: medium),
    bodyLarge: TextStyle(fontFamily: fontFamily, fontWeight: regular),
    bodyMedium: TextStyle(fontFamily: fontFamily, fontWeight: regular),
    bodySmall: TextStyle(fontFamily: fontFamily, fontWeight: regular),
    labelLarge: TextStyle(fontFamily: fontFamily, fontWeight: medium),
    labelMedium: TextStyle(fontFamily: fontFamily, fontWeight: medium),
    labelSmall: TextStyle(fontFamily: fontFamily, fontWeight: medium),
  );
}
