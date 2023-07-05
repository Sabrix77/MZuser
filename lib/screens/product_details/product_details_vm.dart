import 'package:mzady/base.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/screens/product_details/product_details_vavigator.dart';
import 'package:mzady/services/database_utils.dart';
import 'package:mzady/shared/constants/app_strings.dart';

class ProductDetailsViewModel extends BaseViewModel<ProductDetailsNavigator> {
  Product? product;
  DateTime? endDate;
  String? errorMessage;
  List<String>? biddersName ;
  List<dynamic>? biddersBid ;

  List<Product>? similarProducts;

  Future<void> getProductDetails(String productId) async {
    try {
      product = await DatabaseUtils.getProductDetailsByID(productId);
      endDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(product!.endDate));
      print('===================>1');

      print('===================>2');
     await getBidderHistory();

      /// get all products for same category
      getProductsListByCategory(product!.category);
    } catch (e) {
      errorMessage = AppStrings.someThingWentWrong;

      print('======ProductDetailsViewModel ERROR===>$e');
    }
    notifyListeners();
  }

  Future<void> setNweBidToProduct(
      {required Product product,
      required String newWinner,
      required int newBid,
      required String sellerId}) async {
    try {
      print('================77');
      if (newWinner == sellerId) {
        navigator!.showMessage(
            'Oops, it looks like you are the auction seller you can\'t bid your own auction.\nPlease wait for someone else who bid',
            'OK');
      }
      else if (newWinner == product.winnerID.last) {
        navigator!.showMessage(
            'Oops, it looks like you are last one who bid that auction.\nPlease wait till others bid',
            'OK');
      } else {
        navigator!.showLoading();
        product.biggestBid.add(newBid);
        product.winnerID.add(newWinner);

        await DatabaseUtils.setBidToProduct(product);
        navigator!.hideDialog();
        navigator!.hideDialog();
        navigator!.showMessage(
            'You Add New Bid successfully,\nWe wish you all luck for winning.',
            'ok');
      }
      getProductDetails(product.id);
    } catch (e) {
      navigator!.hideDialog();
      navigator!.hideDialog();
      navigator!.showMessage(e.toString(), 'ok');
      //print('$e');
    }
  }

  Future<void> getProductsListByCategory(String category) async {
    try {
      //function is called after getting product so it will not be null
      similarProducts = await DatabaseUtils.getProductsListByCategory(category);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  getBidderHistory() async{
    biddersName = [];
    biddersBid=[];
    for (int i = product!.winnerID.length - 1; i > 0; i--) {
      print('===================>3>$i');
      if(biddersBid!.contains(product!.biggestBid[i]))  continue;
      await DatabaseUtils.getUserData(product!.winnerID[i]).then((bidderData) {
        print('===================>4>$i');
        biddersName!.add('${bidderData.firstName} ${bidderData.lastName}');
        biddersBid!.add(product!.biggestBid[i]);
      });
      print('===================>5');
    }
  }
}
