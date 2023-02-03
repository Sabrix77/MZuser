import 'package:flutter/material.dart';

import '../../login/login_screen.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(LoginScreen.routeName);
        // Navigator.pushNamed(context, LoginScreen.routeName);
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
