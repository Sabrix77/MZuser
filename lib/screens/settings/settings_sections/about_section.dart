import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
              //  height: 800,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.about_us,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.about_us_text_sec1,
                          style: TextStyle(fontSize: 16, height: 1.2),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.about_us_text_sec2,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.about_us_text_sec3,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListTile(
          leading: const Icon(Icons.info, color: Colors.grey),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.about_us,
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
