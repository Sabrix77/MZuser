import 'package:flutter/material.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/screens/login/login_screen.dart';

import '../../shared/combonent/custom_text_field.dart';
import '../../shared/combonent/main_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

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
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
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
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          hint: 'Enter your last Name',
                          label: 'Last Name',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  CustomTextField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid Email';
                      }
                      return null;
                    },
                    hint: 'Enter your Email',
                    label: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid Phone number';
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
                      if (value!.isEmpty) {
                        return ' Please enter your password';
                      }
                      return null;
                    },
                    hint: 'Enter your Password',
                    label: 'Password',
                    obscureText: true,
                    suffixIcon: const Icon(Icons.remove_red_eye),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _confirmController,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'your password is not confirmed, try again';
                      }
                      return null;
                    },
                    obscureText: true,
                    suffixIcon: const Icon(Icons.remove_red_eye),
                    hint: 'Confirm your Password',
                    label: 'Confirm Password',
                  ),
                  const SizedBox(height: 40),
                  MainButton(
                    onTap: () {
                      //if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, HomeLayout.routeName);
                      //}
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
                          child: Text('Login now!')),
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
}
