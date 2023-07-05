import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/settings/settings_sections/uploaded_products/uploaded_products_navigator.dart';
import 'package:mzady/services/database_utils.dart';

class UploadedProductsViewModel
    extends BaseViewModel<UploadedProductsNavigator> {
  List<Product>? products;

  String? errorMessage;

  void getProductsWitchUserUpload(
      {required String userId, required String auctionState}) async {
    try {
      products = await DatabaseUtils.getProductsWitchUserUpload(
          userId: userId, auctionState: auctionState);
    } catch (e) {
      errorMessage = '';
      print('------>ERROR IN :: $e');
    }
    notifyListeners();
  }
}
