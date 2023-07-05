// import 'package:flutter/material.dart';
// import 'package:mzady/screens/layout/home_layout.dart';
// import 'package:mzady/screens/manage_products/exist_list/exists_products_list.dart';
// import 'package:mzady/shared/app_strings.dart';
//
// import 'waiting_list/waiting_products_list.dart';
//
// class ManageProductsScreen extends StatefulWidget {
//   static const String routeName = 'mangeProducts';
//
//   @override
//   _ManageProductsScreenState createState() => _ManageProductsScreenState();
// }
//
// class _ManageProductsScreenState extends State<ManageProductsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: Text(AppStrings.appName),
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, HomeLayout.routeName);
//               },
//               icon: Icon(Icons.arrow_back)),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 text: 'Waiting List',
//                 icon: Icon(Icons.filter),
//               ),
//               Tab(
//                 text: 'All Products',
//                 icon: Icon(Icons.my_library_add),
//               )
//             ],
//           ),
//         ),
//         body: const TabBarView(children: [
//           WaitingProductsList(),
//           ExistProductsList(),
//         ]),
//       ),
//     );
//   }
// }
