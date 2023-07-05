import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/about_section.dart';
import 'package:mzady/screens/settings/settings_sections/delivery_policy_section.dart';
import 'package:mzady/screens/settings/settings_sections/header_info_section.dart';
import 'package:mzady/screens/settings/settings_sections/language_section.dart';
import 'package:mzady/screens/settings/settings_sections/logout_section.dart';
import 'package:mzady/screens/settings/settings_sections/messages/messages_screen.dart';
import 'package:mzady/screens/settings/settings_sections/style_section.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_info.dart';
import 'package:mzady/shared/style/app_theme.dart';
import 'package:provider/provider.dart';

import 'settings_sections/gained_products/Gained_products_screen.dart';
import 'settings_sections/uploaded_products/uploaded_products_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MainProvider>(context);

    return SafeArea(
      child: Container(
        color: provider.myTheme==MyThemeData.lightTheme?Color(0xFFF1EFEF):null,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 50),
                child: HeaderInfoSection(),
              ),
              const UpdateAccountInfo(),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(MessagesScreen.routeName);
                },
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: ListTile(
                    leading: const Icon(Icons.email,color: Colors.grey),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          AppLocalizations.of(context)!.messages,
                          style: TextStyle(fontSize: 18,color:Theme.of(context).colorScheme.onSurface),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(UploadedProductsScreen.routeName);
                },
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart_sharp,color: Colors.grey),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          AppLocalizations.of(context)!.uploaded_products,
                          style: TextStyle(fontSize: 18,color:Theme.of(context).colorScheme.onSurface),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(GainedProductsScreen.routeName);
                },
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart_checkout_outlined, color: Colors.grey),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.gained_products,
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const StyleSection(),
              const SizedBox(height: 8),
              const LanguageSection(),
              const SizedBox(height: 8),
               AboutSection(),
              const SizedBox(height: 8),
               DeliveryPolicySection(),
              const SizedBox(height: 8),
              LogoutSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
