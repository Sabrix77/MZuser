import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFE5E5E5),
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
                    'Register',
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
                              return 'Please Enter First Name';
                            }
                            return null;
                          },
                          hint: 'Enter your First Name',
                          label: 'First Name',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastNameController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return 'Please Enter Last Name';
                            }
                            return null;
                          },
                          hint: 'Enter your Last Name',
                          label: 'Last Name',
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
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                    hint: 'Enter your Email',
                    label: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneController,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.length != 11) {
                        return 'Please Enter Valid Phone Number';
                      }
                      return null;
                    },
                    hint: 'Enter your Phone number',
                    label: 'Phone Number',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return ' Password Should be Strong';
                      }
                      return null;
                    },
                    hint: 'Enter your Password',
                    label: 'Password',
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
                        return 'Please Confirm your Password';
                      }
                      if (value != _passwordController.text) {
                        return 'Your Password Cant be Confirmed, try again';
                      }
                      return null;
                    },
                    hint: 'Confirm your Password',
                    label: 'Confirm Password',
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
                    text: 'Register',
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do you have an account ? '),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text(
                            'Login now!',
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
