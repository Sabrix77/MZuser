import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/base.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/screens/login/login_screen.dart';
import 'package:mzady/screens/register/register_navigator.dart';
import 'package:mzady/screens/register/register_vm.dart';

import '../../shared/combonent/custom_text_field.dart';
import '../../shared/combonent/main_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseView<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isObscure = true;
  bool isConfirmObscure = true;

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 24, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.register,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _firstNameController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return AppLocalizations.of(context)!.enter_valid_first_name;
                            }
                            return null;
                          },
                          hint: AppLocalizations.of(context)!.enter_first_name,
                          label: AppLocalizations.of(context)!.first_name,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastNameController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return AppLocalizations.of(context)!.enter_valid_last_name;
                            }
                            return null;
                          },
                          hint: AppLocalizations.of(context)!.enter_last_name,
                          label: AppLocalizations.of(context)!.last_name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  CustomTextField(
                    controller: _emailController,
                    validator: (value) {
                      final bool emailNotValid = !RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty || emailNotValid) {
                        return AppLocalizations.of(context)!.enter_valid_mail;
                      }
                      return null;
                    },
                    hint: AppLocalizations.of(context)!.enter_mail,
                    label: AppLocalizations.of(context)!.email,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneController,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.length != 11) {
                        return AppLocalizations.of(context)!.enter_valid_phone_number;
                      }
                      return null;
                    },
                    hint: AppLocalizations.of(context)!.enter_phone_number,
                    label: AppLocalizations.of(context)!.phone_number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return AppLocalizations.of(context)!.password_is_week;
                      }
                      return null;
                    },
                    hint: AppLocalizations.of(context)!.enter_password,
                    label: AppLocalizations.of(context)!.password,
                    obscureText: isObscure,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(Icons.remove_red_eye)),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _confirmController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.enter_valid_confirm_password;
                      }
                      if (value != _passwordController.text) {
                        return AppLocalizations.of(context)!.password_not_confirmed;
                      }
                      return null;
                    },
                    hint: AppLocalizations.of(context)!.enter_confirm_password,
                    label: AppLocalizations.of(context)!.confirm_password,
                    obscureText: isConfirmObscure,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmObscure = !isConfirmObscure;
                          });
                        },
                        icon: const Icon(Icons.remove_red_eye)),
                  ),
                  const SizedBox(height: 40),
                  MainButton(
                    onTap: () {
                      validForm();
                    },
                    text: AppLocalizations.of(context)!.register_btn,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(AppLocalizations.of(context)!.do_you_have_account),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child:  Text(
                            AppLocalizations.of(context)!.login_now,
                            style: TextStyle(
                                fontSize: 16, color: Colors.blueAccent),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  void navigateToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  void validForm() {
    if (_formKey.currentState!.validate()) {
      viewModel.createAccount(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
    }
  }
}
