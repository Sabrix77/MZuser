import 'package:flutter/material.dart';

class CustomBodyDrawer extends StatelessWidget {
  const CustomBodyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        // runSpacing: 0,
        children: [
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            title:
                Text('الرئيسية', style: Theme.of(context).textTheme.titleLarge),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()));
              // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          Divider(thickness: .5),


          ListTile(
            leading: Icon(
              Icons.share,
              color: Theme.of(context).primaryColor,
            ),
            title:
                Text('مشاركة', style: Theme.of(context).textTheme.titleLarge),
            onTap: () {
              Navigator.of(context).pop();
              //Share.share(AppStrings.shareMessage);
              // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          Divider(thickness: .5),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Theme.of(context).primaryColor,
            ),
            title:
                Text('إتصل بنا', style: Theme.of(context).textTheme.titleLarge),
            onTap: () {
              Navigator.of(context).pop();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => WebViewApp(url: contactUsUrl),
              //   ),
              // );
            },
          ),
        ]);
  }
}
