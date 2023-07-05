// import 'package:mzady/base.dart';
//
// import '../../../model/product.dart';
// import '../../../services/database_utils.dart';
// import '../../../shared/app_strings.dart';
//
// class WaitingListVieModel extends BaseViewModel {
//   List<Product>? products;
//
//   String? errorMessage;
//
//   void getWaitedProducts() async {
//     try {
//       products = await DatabaseUtils.getSelectedProductsList(confirmed: false);
//     } catch (e) {
//       errorMessage = AppStrings.someThingWentWrong;
//     }
//     notifyListeners();
//   }
//
//   void updateProduct(Product product) async {
//     try {
//       navigator!.showLoading();
//       product.confirmed = true;
//       await DatabaseUtils.setProductToFirestore(product);
//       navigator!.hideDialog();
//       navigator!.showMessage('Product Successfully Uploaded', 'Ok');
//       getWaitedProducts();
//     } catch (e) {
//       navigator!.hideDialog();
//       navigator!.showMessage(AppStrings.someThingWentWrong, 'ok');
//     }
//   }
//
//   void deleteProduct(String productID) async {
//     try {
//       navigator!.showLoading();
//       await DatabaseUtils.deleteProductFromFirestore(productID);
//       navigator!.hideDialog();
//       navigator!.showMessage('Product Successfully Deleted', 'Ok');
//
//       ///to rebuild screen after item is deleted
//       getWaitedProducts();
//     } catch (e) {
//       navigator!.hideDialog();
//       navigator!.showMessage('something went wrong', 'Ok');
//     }
//   }
// }
