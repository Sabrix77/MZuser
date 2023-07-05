import 'package:flutter/material.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:provider/provider.dart';
class LanguageSection extends StatelessWidget {
  const LanguageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MainProvider>(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 200,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 3,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if(provider.language!='en') provider.changeLanguage('en');
                        },
                        child:provider.language=='en'?selectLanguage('English'):unSelectLanguage('English'),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if(provider.language!='ar') provider.changeLanguage('ar');
                        },
                        child:provider.language=='ar'?selectLanguage('العربية'):unSelectLanguage("العربية"),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListTile(
          leading: const Icon(Icons.language,color: Colors.grey),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onSurface),
              ),
              Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectLanguage(String language) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language,
            style: TextStyle(fontSize: 18),
          ),
          const Icon(
            Icons.check,
            size: 26,
            color: Colors.deepOrange,
          )
        ],
      ),
    );
  }

  Widget unSelectLanguage(String language) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
