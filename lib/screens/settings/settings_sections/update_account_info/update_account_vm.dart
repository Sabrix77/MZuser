import 'package:mzady/base.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_navigator.dart';

class UpdateAccountViewModel extends BaseViewModel<UpdateAccountNavigator> {
  // void updateAccount({
  //   required String userId,
  //   required MyUser oldUser,
  //   String? newEmail,
  //   String? newPassword,
  //   String? newAddress,
  //   String? newPhone,
  // }) async {
  //   try {
  //     navigator!.showLoading();
  //     MyUser newUser = MyUser(
  //       id: oldUser.id,
  //       firstName: oldUser.firstName,
  //       lastName: oldUser.lastName,
  //       email: newEmail ?? oldUser.email,
  //       phone: newPhone ?? oldUser.phone,
  //       address: newAddress ?? oldUser.address,
  //     );
  //
  //     if (newEmail != null) {
  //       await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
  //     }
  //     if (newPassword != null) {
  //       await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  //     }
  //
  //     await FirebaseUtils.instance.setDocument(
  //         path: FirebasePaths.getUsersPath(userId), data: newUser.toJson());
  //     navigator!.hideDialog();
  //     navigator!.showMessage(AppStrings.userUpdatedSuccessfully, AppStrings.ok);
  //   } catch (e) {
  //     navigator!.hideDialog();
  //     navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
  //   }
  // }
}
