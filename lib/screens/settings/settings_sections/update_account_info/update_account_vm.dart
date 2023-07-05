import 'package:firebase_auth/firebase_auth.dart';
import 'package:mzady/base.dart';
import 'package:mzady/services/generic_firebase_utils.dart';
import 'package:mzady/shared/constants/app_strings.dart';
import 'package:mzady/shared/constants/firebase_constants.dart';

import '../../../../model/my_user.dart';
import 'update_account_navigator.dart';

class UpdateAccountViewModel extends BaseViewModel<UpdateAccountNavigator> {
  void updateAccount({
    required MyUser oldUser,
    required User fireUser,
    required String newEmail,
    required String newFName,
    required String newLName,
    required String newAddress,
    required String newPhone,
  }) async {
    MyUser newUser = MyUser(
      id: oldUser.id,
      firstName: newFName.isNotEmpty ? newFName : oldUser.firstName,
      lastName: newLName.isNotEmpty ? newLName : oldUser.lastName,
      email: newEmail.isNotEmpty ? newEmail : oldUser.email,
      phone: newPhone.isNotEmpty ? newPhone : oldUser.phone,
      address: newAddress.isNotEmpty ? newAddress : oldUser.address,
      // favProducts: oldUser.favProducts,
    );
    try {
      navigator!.showLoading();
      FirebaseUtils.instance.setDocument(
          path: FirebasePaths.setUserPath(oldUser.id), data: newUser.toJson());
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.userUpdatedSuccessfully, AppStrings.ok);
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
    }
  }
}
