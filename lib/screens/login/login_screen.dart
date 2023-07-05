import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mzady/base.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/screens/login/login_navigator.dart';
import 'package:mzady/screens/login/login_vm.dart';
import 'package:mzady/screens/register/register_screen.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
import 'package:mzady/shared/combonent/main_button.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void initState() {
    //مهم
    super.initState();
    viewModel.navigator = this;
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xFFE5E5E5),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 24, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.login,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 80),
                  CustomTextField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.enter_valid_mail;
                      }
                      return null;
                    },
                    hint: AppLocalizations.of(context)!.enter_mail,
                    label: AppLocalizations.of(context)!.email,
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.enter_valid_password;
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
                  const SizedBox(height: 18),
                  // const Text(
                  //   'Forget your password?',
                  //   textAlign: TextAlign.right,
                  // ),
                  const SizedBox(height: 32),
                  MainButton(
                    onTap: () {
                      formValidator(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    text: AppLocalizations.of(context)!.login_btn,
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(AppLocalizations.of(context)!.dont_have_account),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          },
                          child:  Text(
                            AppLocalizations.of(context)!.register_now,
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

  void formValidator(String email, String password) {
    if (_formKey.currentState!.validate()) {
      viewModel.loginWithEmailAndPassword(email, password);
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void navigateToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }
}
