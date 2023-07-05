import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/layout/home_layout.dart';
import 'package:mzady/screens/login/login_screen.dart';
import 'package:mzady/screens/product_details/product_details.dart';
import 'package:mzady/screens/register/register_screen.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/check_out/credit_check_out.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/gained_products_screen.dart';
import 'package:mzady/screens/settings/settings_sections/messages/messages_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/local_product.dart';
import 'screens/settings/settings_sections/gained_products/check_out/check_out_screen.dart';
import 'screens/settings/settings_sections/gained_products/check_out/success_order.dart';
import 'screens/settings/settings_sections/uploaded_products/uploaded_products_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
        // UploadedScreen.routeName: (_) => UploadedScreen(),
        UploadedProductsScreen.routeName: (_) => UploadedProductsScreen(),
        GainedProductsScreen.routeName: (_) => GainedProductsScreen(),
        // WinningScreen.routeName: (_) => WinningScreen(),
        // ManageProductsScreen.routeName: (_) => ManageProductsScreen(),
        MessagesScreen.routeName: (_) => MessagesScreen(),
        CheckOutScreen.routeName: (_) => CheckOutScreen(),
        SuccessOrder.routeName: (_) => SuccessOrder(),
        CreditCheckOut.routeName: (_) => CreditCheckOut(),
      },
      locale: Locale(mainProvider.language),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
