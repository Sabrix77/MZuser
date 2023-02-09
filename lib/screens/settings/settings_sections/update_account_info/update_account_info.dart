import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_navigator.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_vm.dart';
import 'package:provider/provider.dart';

import '../../../../shared/combonent/custom_text_field.dart';

class UpdateAccountInfo extends StatefulWidget {
  const UpdateAccountInfo({Key? key}) : super(key: key);

  @override
  State<UpdateAccountInfo> createState() => _UpdateAccountInfoState();
}

class _UpdateAccountInfoState
    extends BaseView<UpdateAccountInfo, UpdateAccountViewModel>
    implements UpdateAccountNavigator {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emialController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<MainProvider>(context).user;
    if (user == null) {}

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
                      children: [
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _fNameController,
                          validator: (value) {},
                          label: 'First Name',
                          hint: user.firstName,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _lNameController,
                          validator: (value) {},
                          label: 'Last Name',
                          hint: user.lastName,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emialController,
                          validator: (value) {},
                          label: 'Email',
                          hint: user.email,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _phoneController,
                          validator: (value) {},
                          label: 'Phone',
                          hint: user.phone,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _addressController,
                          validator: (value) {},
                          label: 'Address',
                          hint: user.address.isEmpty
                              ? 'Not updated'
                              : user.address,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancle'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
}
