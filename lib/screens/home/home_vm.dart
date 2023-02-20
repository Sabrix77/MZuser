import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/home/home_navigator.dart';
import 'package:mzady/services/database_utils.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  // String? errorMessage;
  String? selectedCategory;

  List<Product>? products;

  void getAllConfirmedProducts() async {
    try {
      products = await DatabaseUtils.getSelectedProductsList(confirmed: true);
    } catch (e) {
      print('=============$e');
    }
    notifyListeners();
  }

  void getProductsListByCategory(String category) async {
    try {
      products = await DatabaseUtils.getProductsListByCategory(category);
      selectedCategory = category;
      print('=============getProductsListByCategory${products?.length}');
    } catch (e) {
      print('=============$e');
    }
    notifyListeners();
  }

// void setCategory(String category) {
//   selectedCategory = category;
//   print('-------set Cat------$selectedCategory');
//
//   notifyListeners();
// }
}
