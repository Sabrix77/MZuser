import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_navigator.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_vm.dart';
import 'package:mzady/shared/combonent/utilis.dart' as utils;
import 'package:provider/provider.dart';

import '../../../../shared/combonent/custom_text_field.dart';
import '../../../layout/home_layout.dart';

class UpdateAccountInfo extends StatefulWidget {
  const UpdateAccountInfo({Key? key}) : super(key: key);

  @override
  State<UpdateAccountInfo> createState() => _UpdateAccountInfoState();
}

class _UpdateAccountInfoState
    extends BaseView<UpdateAccountInfo, UpdateAccountViewModel>
    implements UpdateAccountNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emialController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emialController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MainProvider>(context).user!;
    User fireUser = Provider.of<MainProvider>(context).firebaseUser!;

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text('Update Account Info'),
                  titleTextStyle: Theme.of(context).textTheme.titleLarge,
                  content: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text('First Name:',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14)),
                        const SizedBox(height: 2),
                        CustomTextField(
                          controller: _fNameController,
                          validator: (value) {},
                          hint: user.firstName,
                        ),
                        const SizedBox(height: 12),
                        Text('Last Name: ',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14)),
                        const SizedBox(height: 2),
                        CustomTextField(
                          controller: _lNameController,
                          validator: (value) {},
                          hint: user.lastName,
                        ),
                        const SizedBox(height: 12),
                        Text('Email:',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14)),
                        const SizedBox(height: 2),
                        CustomTextField(
                          controller: _emialController,
                          validator: (value) {},
                          hint: user.email,
                        ),
                        const SizedBox(height: 12),
                        Text('Phone:',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14)),
                        const SizedBox(height: 2),
                        CustomTextField(
                          controller: _phoneController,
                          textInputType: TextInputType.phone,
                          validator: (value) {},
                          hint: user.phone,
                        ),
                        const SizedBox(height: 12),
                        Text('Address:',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14)),
                        const SizedBox(height: 2),
                        CustomTextField(
                            controller: _addressController,
                            validator: (value) {},
                            hint: user.address),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_fNameController.text.isNotEmpty ||
                            _lNameController.text.isNotEmpty ||
                            _emialController.text.isNotEmpty ||
                            _addressController.text.isNotEmpty ||
                            (_phoneController.text.isNotEmpty &&
                                _phoneController.text.length != 11)) {
                          viewModel.updateAccount(
                            oldUser: user,
                            fireUser: fireUser,
                            newFName: _fNameController.text,
                            newLName: _lNameController.text,
                            newEmail: _emialController.text,
                            newPhone: _phoneController.text,
                            newAddress: _addressController.text,
                          );
                        }
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Update Profile',
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }

  @override
  UpdateAccountViewModel initViewModel() {
    return UpdateAccountViewModel();
  }

  @override
  void hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void showMessage(String message, String positiveBtnTxt) {
    utils.showMessage(context, message, positiveBtnTxt, (context) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeLayout.routeName, (route) => false);
    });
  }
}
