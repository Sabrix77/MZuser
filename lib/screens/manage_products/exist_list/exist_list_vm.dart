import 'package:mzady/base.dart';
import 'package:mzady/services/database_utils.dart';
import 'package:mzady/shared/app_strings.dart';

import '../../../model/product.dart';

class ExistListViewModel extends BaseViewModel {
  List<Product>? products;

  String? errorMessage;

  void getAllProducts() async {
    try {
      products = await DatabaseUtils.getAllProductsList();
    } catch (e) {
      errorMessage = AppStrings.someThingWentWrong;
    }
    notifyListeners();
  }

  void deleteProduct(String productID) async {
    try {
      navigator!.showLoading();
      await DatabaseUtils.deleteProductFromFirestore(productID);
      navigator!.hideDialog();
      navigator!.showMessage('Product Successfully Deleted', 'Ok');

      ///to rebuild screen after item is deleted
      getAllProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage('something went wrong', 'Ok');
    }
  }
}
