import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mzady/screens/settings/settings_sections/about_section.dart';
import 'package:mzady/screens/settings/settings_sections/delivery_policy_section.dart';
import 'package:mzady/screens/settings/settings_sections/header_info_section.dart';
import 'package:mzady/screens/settings/settings_sections/history_uploaded.dart';
import 'package:mzady/screens/settings/settings_sections/history_winning.dart';
import 'package:mzady/screens/settings/settings_sections/language_section.dart';
import 'package:mzady/screens/settings/settings_sections/logout_section.dart';
import 'package:mzady/screens/settings/settings_sections/style_section.dart';
import 'package:mzady/screens/settings/settings_sections/update_account_info/update_account_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF1EFEF),
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
              HistoryUploaded(),
              SizedBox(height: 8),
              HistoryWinning(),
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
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
