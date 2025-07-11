// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData customDarkThem = ThemeData.dark().copyWith(
      primaryColor: Color(0xFFF7F5F5),
      colorScheme: ColorScheme(
        primary: Colors.teal,
        secondary: Color(0xFFFE270D),
        surface: Colors.black,
        onSurface: Colors.green,
        surfaceContainerLow: Colors.black,
        brightness: Brightness.light,
        onError: Colors.red,
        onPrimary: const Color.fromARGB(255, 26, 51, 140),
        onSecondary: Colors.white,
        error: Colors.grey.shade900,
      ),
      tabBarTheme: TabBarThemeData(
          indicatorColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(186, 224, 216, 216)));
  static ThemeData customLightThem = ThemeData.light().copyWith(
      primaryColor: Color(0xFF100F0F),
      colorScheme: ColorScheme(
        primary: Colors.teal,
        secondary: Color(0xFFFE270D),
        surface: Colors.white,
        surfaceContainerLow: Colors.black,
        onSurface: Colors.green,
        brightness: Brightness.light,
        onError: Colors.red,
        onPrimary: const Color.fromARGB(255, 40, 65, 154),
        onSecondary: Colors.black,
        error: Colors.grey,
      ),
      tabBarTheme: TabBarThemeData(
          indicatorColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(186, 224, 216, 216)));
  static CupertinoThemeData cupertinoLightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    barBackgroundColor: Colors.black,
    textTheme: const CupertinoTextThemeData(
      textStyle: TextStyle(color: Colors.black),
      actionTextStyle: TextStyle(color: Colors.teal),
      tabLabelTextStyle: TextStyle(fontSize: 10, color: Colors.teal),
      navTitleTextStyle: TextStyle(color: Colors.black, fontSize: 17),
    ),
  );

  static CupertinoThemeData cupertinoDarkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.black,
    barBackgroundColor: Colors.white,
    textTheme: const CupertinoTextThemeData(
      textStyle: TextStyle(color: Colors.white),
      actionTextStyle: TextStyle(color: Colors.teal),
      tabLabelTextStyle: TextStyle(fontSize: 10, color: Colors.teal),
      navTitleTextStyle: TextStyle(color: Colors.white, fontSize: 17),
    ),
  );
}
