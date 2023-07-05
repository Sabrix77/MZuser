import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mzady/model/my_user.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/shared/constants/enums.dart';

class DatabaseUtils {
  static CollectionReference<Product> getProductCollectionRef() {
    return FirebaseFirestore.instance
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snapshot, options) =>
              Product.fromJson(snapshot.data()!),
          toFirestore: (product, options) => product.toJson(),
        );
  }

  static setProductToFirestore(Product product) async {
    var ref = getProductCollectionRef();
    return await ref.doc(product.id).set(product);
  }

  static deleteProductFromFirestore(String productID) async {
    var ref = getProductCollectionRef();
    return await ref.doc(productID).delete();
  }

  static Future<List<Product>> getConfirmedProductsList() async {
    // this method showing confirmed products for user
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref

          .where('auctionState', isEqualTo: AuctionState.confirmed.name)
          .get();

      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      throw (e);
    }
  }

  // static Future<List<Product>> getAllProductsList() async {
  //   try {
  //     var ref = getProductCollectionRef();
  //     QuerySnapshot<Product> productsSnapshot = await ref.get();
  //     List<Product> products =
  //         productsSnapshot.docs.map((e) => e.data()).toList();
  //     return products;
  //   } catch (e) {
  //     throw (e);
  //   }
  // }

  static Future<List<Product>> getProductsListByCategory(
      String category) async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref
          .where('category', isEqualTo: category)
          .where('auctionState', isEqualTo: AuctionState.confirmed.name)
          .get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      print('=/=/=======$e');
      throw (e);
    }
  }

  ///doesn't work cause it's fetch data start with "title" not contain "title"
  // static Future<List<Product>> getProductsListByTitleSearch(
  //     String title) async {
  //   try {
  //     var ref = getProductCollectionRef();
  //     QuerySnapshot<Product> productsSnapshot = await ref
  //         .orderBy('title')
  //         .startAt([title]).endAt(['$title\uf8ff']).get();
  //     List<Product> products =
  //         productsSnapshot.docs.map((e) => e.data()).toList();
  //     return products;
  //   } catch (e) {
  //     print('=========$e');
  //     throw (e);
  //   }
  // }

  static Future<Product> getProductDetailsByID(String productId) async {
    try {
      var ref = getProductCollectionRef();
      DocumentSnapshot<Product> product = await ref.doc(productId).get();
      return product.data()!;
    } catch (e) {
      print('====//===$e');
      throw (e);
    }
  }

  static Future<List<Product>> getProductsWitchUserWin(
      {required String userId, required String auctionState}) async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref
          //.where('winnerID', whereIn: 'W426jDQExuXfw9Sxsj7DxZdFYBu1')
          .where('auctionState', isEqualTo: auctionState)
          .get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      print('===>===>==gained:${products.length}');

      return products;
    } catch (e) {
      print('========///=$e');
      throw (e);
    }
  }

  static Future<List<Product>> getProductsWitchUserUpload(
      {required String userId, required String auctionState}) async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref
          .where('sellerId', isEqualTo: userId)
          .where('auctionState', isEqualTo: auctionState)
          .get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();

      return products;
    } catch (e) {
      print('=||||========$e');
      throw (e);
    }
  }

  static Future<void> setBidToProduct(
      Product product) async {
    var ref = getProductCollectionRef();
    return await ref
        .doc(product.id)
        .update({'biggestBid': product.biggestBid, 'winnerID': product.winnerID});
  }


  static Future<MyUser> getUserData(String uid) async {
    var user =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return MyUser.fromJson(user.data()!);
  }

}
