import 'package:flutter/material.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/delivered/delivered_gained_screen.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/onprogress/onprogress_gained_screen.dart';

class GainedProductsScreen extends StatefulWidget {
  const GainedProductsScreen({Key? key}) : super(key: key);
  static const String routeName = 'GainedProductsScreen';

  @override
  _GainedProductsScreenState createState() => _GainedProductsScreenState();
}

class _GainedProductsScreenState extends State<GainedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Gained Products',
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
                text: 'Delivered',
                icon: Icon(Icons.local_shipping),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          OnProgressGainedScreen(),
          DeliveredGainedScreen(),
        ]),
      ),
    );
  }
}
