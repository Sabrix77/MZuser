import 'package:flutter/material.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white70,
    // primarySwatch: Colors.red,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
      colorScheme: const ColorScheme(
       brightness : Brightness.light,
       primary : Color(0xff6200ee),
       onPrimary : Colors.white,
       secondary : Color(0xff03dac6),
       onSecondary : Colors.black,
       error : Color(0xffb00020),
       onError : Colors.white,
       background : Colors.white,
       onBackground : Color(0xff121212),
       surface : Colors.white,
       onSurface : Colors.black,

      ),
      /// | headline5  | 24.0 | regular |  0.0     |             |
      /// | headline6  | 20.0 | medium  |  0.15    |             |
      /// | subtitle1  | 16.0 | regular |  0.15    |             |
      /// | subtitle2  | 14.0 | medium  |  0.1     |             |
      /// | body1      | 16.0 | regular |  0.5     | (bodyText1) |
      /// | body2      | 14.0 | regular |  0.25    | (bodyText2) |
      /// | button     | 14.0 | medium  |  1.25    |             |
      /// | caption    | 12.0 | regular |  0.4     |             |
      /// | overline   | 10.0 | regular |  1.5     |             |
      textTheme: const TextTheme(
        headline5: TextStyle(height: 1),
        headline6: TextStyle(height: 1),
        subtitle1: TextStyle(height: 1),
        subtitle2: TextStyle(height: 1),
        bodyText1: TextStyle(height: 1),
        bodyText2: TextStyle(height: 1),
        button: TextStyle(height: 1),
        caption: TextStyle(height: 1),
        overline: TextStyle(height: 1),

      )
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Cairo',

    brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      colorScheme: const ColorScheme(
        primary: Color(0xffbb86fc),
        onPrimary: Colors.black,
        secondary: Color(0xff03dac6),
        onSecondary: Colors.black,
        error: Color(0xffcf6679),
        onError: Colors.white,
        background: Color(0xff121212),
        onBackground: Color(0xff121212),
        surface: Color(0xff121212),
        onSurface: Colors.white,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(height: 1),
        headline6: TextStyle(height: 1),
        subtitle1: TextStyle(height: 1),
        subtitle2: TextStyle(height: 1),
        bodyText1: TextStyle(height: 1),
        bodyText2: TextStyle(height: 1),
        button: TextStyle(height: 1),
        caption: TextStyle(height: 1),
        overline: TextStyle(height: 1),

      )
  );





}
