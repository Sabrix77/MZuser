import 'package:mzady/base.dart';
import 'package:mzady/screens/login/login_navigator.dart';
import 'package:mzady/services/auth_manager.dart';
import 'package:mzady/shared/app_strings.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  bool isObscure = true;

  loginWithEmailAndPassword(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential =
          await AuthManager.logInWithEmailAndPassword(email, password);

      //saving to fire store;
      navigator!.hideDialog();
      navigator!.navigateToHome();
    } catch (e) {
      print('cant login');
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.youCantLogin, AppStrings.ok);
    }
  }

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
