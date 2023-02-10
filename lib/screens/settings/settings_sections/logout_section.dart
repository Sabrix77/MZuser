import 'package:flutter/material.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/services/auth_manager.dart';
import 'package:provider/provider.dart';

import '../../login/login_screen.dart';

class LogoutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);

    return InkWell(
      onTap: () {
        ///hwa da الاسباكتي altmm
        AuthManager.logout().then((value) {
          mainProvider.firebaseUser = mainProvider.user = null;
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
        });
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
