import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/product_details/product_details_vavigator.dart';
import 'package:mzady/services/database_utils.dart';
import 'package:mzady/shared/app_strings.dart';

class ProductDetailsViewModel extends BaseViewModel<ProductDetailsNavigator> {
  Product? product;
  DateTime? endDate;
  String? errorMessage;

  Future<void> getProductDetails(String productId) async {
    try {
      product = await DatabaseUtils.getProductDetailsByID(productId);
      endDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(product!.endDate));
    } catch (e) {
      errorMessage = AppStrings.someThingWentWrong;
      ;
      print('======ProductDetailsViewModel ERROR===>');
    }
    notifyListeners();
  }
}
