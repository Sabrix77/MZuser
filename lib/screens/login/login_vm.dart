import 'package:firebase_auth/firebase_auth.dart';
import 'package:mzady/base.dart';
import 'package:mzady/screens/login/login_navigator.dart';
import 'package:mzady/services/auth_manager.dart';
import 'package:mzady/shared/constants/app_strings.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  bool isObscure = true;

  loginWithEmailAndPassword(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential =
          await AuthManager.logInWithEmailAndPassword(email, password);

      navigator!.hideDialog();
      navigator!.navigateToHome();
    } on FirebaseAuthException catch (e) {
      print('cant login');
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.youCantLogin, AppStrings.ok);
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
    }
  }

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
