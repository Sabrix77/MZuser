import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/shared/constants/firebase_constants.dart';

import '../shared/style/app_theme.dart';

class MainProvider extends ChangeNotifier {
  late User? firebaseUser;
  MyUser? user;
  ThemeData myTheme = MyThemeData.lightTheme;

  MainProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) initUser();
  }

  void initUser() async {
    print('==== init user');
    user = await getCurrentUser();
  }

  void initUserManually() async {
    print('==== init userManually');
    firebaseUser = FirebaseAuth.instance.currentUser;

    user = await getCurrentUser();
  }

  ///firebase calling should modified and be in services
  Future<MyUser> getCurrentUser() async {
    var currentUser = await FirebaseFirestore.instance
        .doc('${FirebasePaths.usersPath}${firebaseUser!.uid}')
        .get();
    return MyUser.fromJson(currentUser.data()!, firebaseUser!.uid);
  }

  void changeTheme(ThemeData newTheme) {
    myTheme = newTheme;
    notifyListeners();
  }
}
