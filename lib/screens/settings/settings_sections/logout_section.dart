import 'package:flutter/material.dart';
import 'package:mzady/services/auth_manager.dart';

import '../../login/login_screen.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ///hwa da الاسباكتي altmm
        AuthManager.logout().then((value) =>
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                LoginScreen.routeName, (route) => false));
      },
      child: Container(
        color: Colors.redAccent,
        child: ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
