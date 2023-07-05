import 'package:flutter/material.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          // delete favorites Uploaded Items علشان لما يدخل تخرج ويدخل يحمل ليسته اليوزر الجديد
          //ف الهووم اسكرين برفع ليسته بتاع الفيفروت مره واحده ,الفكره اني لما بعمل لوج اوت
          //وادخل من اكونت تاني ف الليسته مش بتتجدد لانها بتكون مرفوعه م اليوزر الاولاني
          // ف انا بقوله لما يعمل لوج اوت خليه ب فولس ولما يدخل تاني ف الهوم تلاقي فولس ف ترفع الليسته جديده
          mainProvider.isDataLoaded = false;
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
            children:  [
              Text(
                AppLocalizations.of(context)!.logout,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
             const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
