import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/style/app_theme.dart';

class MainProvider extends ChangeNotifier {
  ThemeData myTheme = MyThemeData.lightTheme;

  void changeTheme(ThemeData newTheme) {
    myTheme = newTheme;
    notifyListeners();
  }
}
