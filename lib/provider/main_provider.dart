import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/shared/constants/firebase_constants.dart';

import '../model/local_product.dart';
import '../services/local/cash_helper.dart';
import '../shared/style/app_theme.dart';

class MainProvider extends ChangeNotifier {
  late User? firebaseUser;
  MyUser? user;
  bool isAdmin = false;

  // String? adminId;
  ThemeData myTheme = MyThemeData.lightTheme;

  ///favorites section
  List<LocalProduct> localProducts = [];
  String? favoritesErrorMessage;
  bool isDataLoaded = false;

  MainProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) initUser();
  }

  void getLocalProducts() async {
    try {
      localProducts = await CashHelper.instance
          .getAllDataFromLocal(userBoxId: firebaseUser!.uid);
      isDataLoaded = true;
      notifyListeners();
    } catch (e) {
      print(
          'Error in Getting local products:::$e======>length ${localProducts.length}');
      favoritesErrorMessage = 'Cant get items';
    }
  }

  void setLocalProduct(LocalProduct localProduct) async {
    try {
      await CashHelper.instance
          .storeDataLocally(
              userBoxId: firebaseUser!.uid, localProduct: localProduct)
          .then((_) => getLocalProducts());
    } catch (e) {
      favoritesErrorMessage = 'cant store items';
    }
  }

  void deleteLocalItem(LocalProduct localProduct) {
    try {
      CashHelper.instance.deleteItemFromLocal(
          userBoxId: firebaseUser!.uid, localProduct: localProduct);
      getLocalProducts();
    } catch (e) {
      print('error in deleating product=====$e');
    }
  }

  bool isProductSelected(LocalProduct localProduct) {
    // return CashHelper.instance.checkProductIsExist(localProduct);
    for (var i = 0; i < localProducts.length; i++) {
      if (localProducts[i].id == localProduct.id) {
        return true;
      }
    }
    return false;
  }

  void initUser() async {
    user = await getCurrentUser();
    if (user!.isAdmin) {
      print('---------------->$isAdmin');

      isAdmin = true;
      print('---------------->$isAdmin');
      notifyListeners();
    }
  }

  void initUserManually() async {
    firebaseUser = FirebaseAuth.instance.currentUser;

    user = await getCurrentUser();
    if (user!.isAdmin) {
      print('---------------->$isAdmin');

      isAdmin = true;
      print('---------------->$isAdmin');
      notifyListeners();
    }
  }

  ///firebase calling should modified and be in services
  Future<MyUser> getCurrentUser() async {
    var currentUser = await FirebaseFirestore.instance
        .doc('${FirebasePaths.usersPath}${firebaseUser!.uid}')
        .get();
    return MyUser.fromJson(currentUser.data()!);
  }

  ///getting admin id used for messaging
//   void getAdminID() async {
//     var admins = await FirebaseFirestore.instance.collection('users')
//         .where('isAdmin',isEqualTo: true)
//         .get();
//     adminId =admins.docs.first.id;
//     print('ADMIN ID+++++++++++++$adminId');
//
//
//   }

  void changeTheme(ThemeData newTheme) {
    myTheme = newTheme;
    notifyListeners();
  }
}
