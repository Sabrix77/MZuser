import 'package:flutter/material.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/screens/login/login_screen.dart';
import 'package:mzady/screens/register/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MainProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    return MaterialApp(
      title: 'GoBid',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeLayout.routeName,
      theme: mainProvider.myTheme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeLayout.routeName: (_) => HomeLayout(),
      },
    );
  }
}
