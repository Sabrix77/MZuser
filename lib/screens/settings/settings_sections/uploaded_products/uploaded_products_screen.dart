import 'package:flutter/material.dart';
import 'package:mzady/screens/settings/settings_sections/uploaded_products/onprogress/onprogress_uploads_screen.dart';

import 'canceled/canceled_uploads_screen.dart';
import 'finished/finished_uploads_screen.dart';

class UploadedProductsScreen extends StatefulWidget {
  const UploadedProductsScreen({Key? key}) : super(key: key);
  static const String routeName = 'UploadedProductsScreen';

  @override
  _UploadedProductsScreenState createState() => _UploadedProductsScreenState();
}

class _UploadedProductsScreenState extends State<UploadedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Uploaded Products',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onError,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'On Progress',
                icon: Icon(Icons.person_pin_sharp),
              ),
              Tab(
                text: 'Finished',
                icon: Icon(Icons.local_shipping),
              ),
              Tab(
                text: 'Canceled',
                icon: Icon(Icons.remove_shopping_cart_rounded),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          OnProgressUploadsScreen(),
          FinishedUploadsScreen(),
          CanceledUploadsScreen(),
        ]),
      ),
    );
  }
}
