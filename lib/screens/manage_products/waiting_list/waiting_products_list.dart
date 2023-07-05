// import 'package:flutter/material.dart';
// import 'package:mzady/base.dart';
// import 'package:mzady/screens/manage_products/waiting_list/waiting_list_navigator.dart';
// import 'package:mzady/screens/manage_products/waiting_list/waiting_list_vm.dart';
// import 'package:mzady/shared/combonent/utilis.dart' as utils;
// import 'package:provider/provider.dart';
//
// import '../../../model/product.dart';
// import '../../../shared/app_strings.dart';
//
// class WaitingProductsList extends StatefulWidget {
//   const WaitingProductsList({Key? key}) : super(key: key);
//
//   @override
//   _WaitingProductsListState createState() => _WaitingProductsListState();
// }
//
// class _WaitingProductsListState
//     extends BaseView<WaitingProductsList, WaitingListVieModel>
//     implements WaitingListNavigator {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     viewModel.navigator = this;
//     viewModel.getWaitedProducts();
//   }
//
//   @override
//   WaitingListVieModel initViewModel() {
//     return WaitingListVieModel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => viewModel,
//       child: Consumer<WaitingListVieModel>(
//         builder: (_, waitingVM, __) {
//           if (waitingVM.products == null) {
//             // change to shimmer
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (waitingVM.products!.isEmpty) {
//             return const Center(child: Text('Empty Product List'));
//           }
//           if (waitingVM.errorMessage != null) {
//             return const Center(child: Text(AppStrings.someThingWentWrong));
//           }
//           String endDate;
//           //Product product;
//           return ListView.builder(
//               itemCount: waitingVM.products!.length,
//               itemBuilder: (context, index) {
//                 //  product = waitingVM.products![index];
//                 endDate =
//                     convertToEndDateFormate(waitingVM.products![index].endDate);
//                 return Card(
//                   elevation: 5,
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 8),
//                     child: Column(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     waitingVM.products![index].title,
//                                     style: const TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Image.network(
//                                     waitingVM.products![index].imgUrl,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                                 'Start With ${waitingVM.products![index].biggestBid.toString()} LE, and End @ ${endDate}',
//                                 //overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 8),
//                             Container(
//                               color: Colors.grey[300],
//                               child: Text(waitingVM.products![index].category),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(waitingVM.products![index].description,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 16, color: Colors.black54)),
//                             const SizedBox(height: 8),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 deleteProduct(waitingVM.products![index].id);
//                               },
//                               child: Row(
//                                 children: const [
//                                   Icon(Icons.delete),
//                                   SizedBox(width: 4),
//                                   Text('DELETE',
//                                       style: TextStyle(fontSize: 16)),
//                                 ],
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 updateProduct(waitingVM.products![index]);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green[400]),
//                               child: Row(
//                                 children: const [
//                                   Icon(Icons.check_circle_outline,
//                                       color: Colors.black),
//                                   SizedBox(width: 4),
//                                   Text('CONFIRM',
//                                       style: TextStyle(
//                                           fontSize: 16, color: Colors.black)),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               });
//         },
//       ),
//     );
//   }
//
//   String convertToEndDateFormate(String endDate) {
//     return DateTime.fromMillisecondsSinceEpoch(int.parse(endDate))
//         .toString()
//         .substring(0, 10);
//   }
//
//   void updateProduct(Product product) {
//     utils.showMessage(
//         context,
//         'Are you sure you want to upload this product?',
//         'Upload',
//         (context) {
//           viewModel.updateProduct(product);
//           viewModel.navigator!.hideDialog();
//         },
//         negativeBtnTxt: 'Cancel',
//         negativeBtnAct: (context) {
//           viewModel.navigator!.hideDialog();
//         });
//   }
//
//   void deleteProduct(String productID) {
//     utils.showMessage(
//         context, 'Are you sure you want to delete this item?', 'Delete',
//         (context) {
//       viewModel.deleteProduct(productID);
//       viewModel.navigator!.hideDialog();
//     },
//         negativeBtnTxt: 'Cancel',
//         negativeBtnAct: (context) => viewModel.navigator!.hideDialog());
//   }
// }
