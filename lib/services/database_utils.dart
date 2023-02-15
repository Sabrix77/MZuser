import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mzady/model/product.dart';

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

  static Future<List<Product>> getAllProductsList() async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref.get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      throw (e);
    }
  }

  static Future<List<Product>> getProductsListByCategory(
      String category) async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot =
          await ref.where('category', isEqualTo: category).get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      print('=========$e');
      throw (e);
    }
  }

  static Future<Product> getProductDetailsByID(String productId) async {
    try {
      var ref = getProductCollectionRef();
      DocumentSnapshot<Product> product = await ref.doc(productId).get();
      return product.data()!;
    } catch (e) {
      print('=========$e');
      throw (e);
    }
  }
}

///
/// هنخزن الفايف داتا ف اللوكال زي ما مخزنينها بس لما ننافجيت من البرودكت لل للبرودكت ديتيلز هباصي ال id مش البرودكت كله
