import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mzady/screens/settings/settings_sections/about_section.dart';
import 'package:mzady/screens/settings/settings_sections/delivery_policy_section.dart';
import 'package:mzady/screens/settings/settings_sections/header_info_section.dart';
import 'package:mzady/screens/settings/settings_sections/language_section.dart';
import 'package:mzady/screens/settings/settings_sections/logout_section.dart';
import 'package:mzady/screens/settings/settings_sections/style_section.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFE5E5E5),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 50),
                child: HeaderInfoSection(),
              ),
              UpdateAccountInfo(),
              SizedBox(height: 8),
              StyleSection(),
              SizedBox(height: 8),
              LanguageSection(),
              SizedBox(height: 8),
              AboutSection(),
              SizedBox(height: 8),
              DeliveryPolicySection(),
              SizedBox(height: 8),
              LogoutSection(),
            ],
          ),
        ),
      ),
    );
  }
}
