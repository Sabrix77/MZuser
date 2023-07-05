import 'package:flutter/material.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryPolicySection extends StatelessWidget {
  bool? iconNotNeeded;
  DeliveryPolicySection({this.iconNotNeeded});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 800,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.delivery_policy,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.delivery_policy_sec1,
                          style: TextStyle(
                            fontSize:16,
                            fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.delivery_policy_sec2,
                          style: TextStyle(
                              fontSize:16,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),

                        Text(
                          AppLocalizations.of(context)!.delivery_policy_sec3,
                          style: TextStyle(
                              fontSize:16,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),

                        Text(
                          AppLocalizations.of(context)!.delivery_policy_sec4,
                          style: TextStyle(
                              fontSize:16,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),

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
          leading:iconNotNeeded==null? const Icon(Icons.policy, color: Colors.grey):null,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.delivery_policy,
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
