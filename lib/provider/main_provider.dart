import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/services/generic_firebase_utils.dart';
import 'package:mzady/shared/constants/firebase_constants.dart';

import '../shared/style/app_theme.dart';

class MainProvider extends ChangeNotifier {
  late User? firebaseUser;
  late MyUser user;
  ThemeData myTheme = MyThemeData.lightTheme;

  MainProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) initUser();
  }

  void changeTheme(ThemeData newTheme) {
    myTheme = newTheme;
    notifyListeners();
  }

  void initUser() async {
    user = await FirebaseUtils.instance
        .documentStream(
            path: FirebasePaths.getUsersPath(firebaseUser!.uid),
            builder: (data, docId) {
              return MyUser.fromJson(data!, docId);
            })
        .first;
  }

  void initUserManually() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    user = await FirebaseUtils.instance
        .documentStream(
            path: FirebasePaths.getUsersPath(firebaseUser!.uid),
            builder: (data, docId) {
              return MyUser.fromJson(data!, docId);
            })
        .first;
  }
}
