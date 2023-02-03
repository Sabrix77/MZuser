import 'package:flutter/material.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    ),
    primarySwatch: Colors.red,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.redAccent,
      ),
    ),
  );
}
