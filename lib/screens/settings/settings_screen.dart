import 'package:flutter/material.dart';
import 'package:mzady/screens/login/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFE5E5E5),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.lightBlueAccent,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/shopcar.png')),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Hello, ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Omar Muhammad',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blueAccent),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Banimzar-Minya',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
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
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(Icons.style),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Style',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(Icons.language),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Language',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(Icons.info),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'About us',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(Icons.policy),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Delivery Policy',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.redAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(LoginScreen.routeName);
                    // Navigator.pushNamed(context, LoginScreen.routeName);
                  },
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
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
