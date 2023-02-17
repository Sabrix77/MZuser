import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/search/search_navigator.dart';
import 'package:mzady/services/database_utils.dart';
import 'package:mzady/shared/app_strings.dart';

class SearchViewModel extends BaseViewModel<SearchNavigator> {
  List<Product>? products;
  List<Product> filteredProducts = [];
  String? errorMessage;

  void getAllProducts() async {
    try {
      products = await DatabaseUtils.getSelectedProductsList(confirmed: true);

      for (int i = 0; i < products!.length; i++) {
        products![i].title = products![i].title.toLowerCase();
      }
    } catch (e) {
      errorMessage = AppStrings.someThingWentWrong;
    }
  }

  void filterProductListByTitle(String title) {
    title = title.toLowerCase();

    // when searching more than one time u have to remove old list first
    filteredProducts = [];

    //searching for titles which contain "value" not only start wuth this value
    for (int i = 0; i < products!.length; i++) {
      if (products![i].title.contains(title)) {
        filteredProducts.add(products![i]);
      }
    }
    notifyListeners();
  }

  void clearFilteredList() {
    filteredProducts = [];
    notifyListeners();
  }
}
