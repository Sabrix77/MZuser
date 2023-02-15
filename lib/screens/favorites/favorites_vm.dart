import 'package:mzady/base.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/screens/favorites/favorites_navigator.dart';
import 'package:mzady/services/local/cash_helper.dart';

class FavoritesViewModel extends BaseViewModel<FavoritesNavigator> {
  List<LocalProduct>? localProducts;
  String? favoritesErrorMessage;

  void getLocalProducts({required String userBoxId}) async {
    try {
      localProducts =
          await CashHelper.instance.getAllDataFromLocal(userBoxId: userBoxId);
    } catch (e) {
      favoritesErrorMessage = 'Cant get items';
    }
  }

  Future<void> setLocalProduct(
      {required String userBoxId, required LocalProduct localProduct}) async {
    try {
      await CashHelper.instance
          .storeDataLocally(userBoxId: userBoxId, localProduct: localProduct);
    } catch (e) {
      favoritesErrorMessage = 'cant store items';
    }
  }

  deleteLocalProduct(
      {required String userBoxId, required LocalProduct localProduct}) {
    try {
      CashHelper.instance.deleteItemFromLocal(
          userBoxId: userBoxId, localProduct: localProduct);
    } catch (e) {
      favoritesErrorMessage = 'cant delete Item';
    }
  }
}
