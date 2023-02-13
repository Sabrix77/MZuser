import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/home/home_navigator.dart';
import 'package:mzady/services/database_utils.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  // String? errorMessage;
  String? selectedCategory;

  // Stream<List<Product>> productStream() {
  //   print('-------getProducts------$selectedCategory');
  //
  //   return  FirebaseUtils.instance.collectionStream(
  //     path: FirebasePaths.productsPath,
  //     queryBuilder: (query){
  //       if(selectedCategory!=null){
  //       return query.where('category',isEqualTo: selectedCategory);
  //       }
  //       return query.where('available',isEqualTo: false);
  //     },
  //     builder: (data, docId) =>
  //       Product.fromJson(data!, docId)
  //
  //
  //   );
  // }
  List<Product>? products;

  void getAllProductsList() async {
    try {
      products = await DatabaseUtils.getAllProductsList();
    } catch (e) {
      print('=============$e');
    }
    notifyListeners();
  }

  void getProductsListByCategory(String category) async {
    try {
      products = await DatabaseUtils.getProductsListByCategory(category);
      print('=============getProductsListByCategory${products?.length}');
    } catch (e) {
      print('=============$e');
    }
    notifyListeners();
  }

  void setCategory(String category) {
    selectedCategory = category;
    print('-------set Cat------$selectedCategory');

    notifyListeners();
  }
}
