import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme{

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kLightBg,
    colorScheme: const ColorScheme.light(
      secondary: kTeal
    ),
    primaryColor: kWhite,
    iconTheme: const IconThemeData(
      color: kDarkForeground
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: kBlueGrey)
    ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
      ),
    accentColor: kTeal
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: kDarkBg,
    colorScheme: const ColorScheme.dark(
        secondary: kTeal
    ),
      primaryColor: kDarkForeground,
      iconTheme: const IconThemeData(
          color: kWhite
      ),
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: kWhite)
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light, // 2
      ),
      accentColor: kTeal
  );

}