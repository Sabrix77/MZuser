import 'package:firebase_auth/firebase_auth.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/screens/register/register_navigator.dart';
import 'package:mzady/services/generic_firebase_utils.dart';

import '../../services/auth_manager.dart';
import '../../shared/app_strings.dart';
import '../../shared/constants/firebase_constants.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  Future<void> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      navigator!.showLoading();
      final credential = await AuthManager.createUserAccount(email, password);

      ///save to fire store;
      MyUser user = MyUser(
        id: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
      await FirebaseUtils.instance.setDocument(
          path: FirebasePaths.getUsersPath(user.id), data: user.toJson());
      //end of saving user in firestore

      navigator!.hideDialog();
      navigator!.navigateToHome();
    } on FirebaseAuthException catch (e) {
      print('===========================');
      print(e);
      navigator!.hideDialog();
      if (e.code == FirebaseErrors.weakPassword) {
        navigator!.showMessage(AppStrings.weakPassword, AppStrings.ok);
      }
      if (e.code == FirebaseErrors.usedEmail) {
        navigator!.showMessage(AppStrings.usedEmail, AppStrings.ok);
      } else {
        navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
      }
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
    }
  }
}
