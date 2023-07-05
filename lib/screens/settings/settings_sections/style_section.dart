import 'package:flutter/material.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/shared/style/app_theme.dart';
import 'package:provider/provider.dart';
class StyleSection extends StatelessWidget {
  const StyleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
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
                          Navigator.pop(context);

                          mainProvider.changeTheme(MyThemeData.lightTheme);

                        },
                        child: mainProvider.myTheme == MyThemeData.lightTheme
                            ? selectTheme(AppLocalizations.of(context)!.light)
                            : unSelectTheme(AppLocalizations.of(context)!.light),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);

                          mainProvider.changeTheme(MyThemeData.darkTheme);
                        },
                        child: mainProvider.myTheme == MyThemeData.darkTheme
                            ? selectTheme(AppLocalizations.of(context)!.dark)
                            : unSelectTheme(AppLocalizations.of(context)!.dark),
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
          leading: const Icon(Icons.style,color: Colors.grey),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                AppLocalizations.of(context)!.style,
                style: TextStyle(fontSize: 18,color:Theme.of(context).colorScheme.onSurface),
              ),
              Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectTheme(String style) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            style,
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

  Widget unSelectTheme(String style) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            style,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
