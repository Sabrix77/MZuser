import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/gained_products_navigator.dart';
import 'package:mzady/services/database_utils.dart';

class GainedProductsViewModel extends BaseViewModel<GainedProductsNavigator>{
  List<Product>? products;

  String? errorMessage;

  void getProductsWitchUserGain({
     required String userId, required String auctionState
  }) async {
    try {
      products = await DatabaseUtils.getProductsWitchUserWin(
          userId: userId, auctionState: auctionState);
     products= products!.where((element) => element.winnerID.last==userId).toList();
      print('===>>>==gained:${products!.length}');
    } catch (e) {
      errorMessage = '';
      print('------>ERROR IN :: $e');
    }
    notifyListeners();
  }
}