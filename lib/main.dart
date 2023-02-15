import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/screens/login/login_screen.dart';
import 'package:mzady/screens/product_details/product_details.dart';
import 'package:mzady/screens/register/register_screen.dart';
import 'package:mzady/screens/settings/settings_sections/history_uploaded.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/local_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(LocalProductAdapter());
  await Hive.initFlutter();

  print('=======main func');
  runApp(
    ChangeNotifierProvider<MainProvider>(
      create: (context) => MainProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    print('===============Material');
    return MaterialApp(
      title: 'GoBid',
      debugShowCheckedModeBanner: false,
      initialRoute: mainProvider.firebaseUser != null
          ? HomeLayout.routeName
          : LoginScreen.routeName,
      theme: mainProvider.myTheme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeLayout.routeName: (_) => HomeLayout(),
        ProductDetails.routeName: (_) => ProductDetails(),
        UploadedScreen.routeName: (_) => UploadedScreen(),
      },
    );
  }
}
