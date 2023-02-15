import 'package:hive/hive.dart';
import 'package:mzady/model/local_product.dart';

class CashHelper {
  ///creating singleton obj.
  CashHelper._();

  static CashHelper instance = CashHelper._();

  // String dbBox = 'products';

  //!Create Hive Box Database
  Future<Box> createBoxDb(String userBoxId) async {
    print('------------>$userBoxId');
    Box box = await Hive.openBox<LocalProduct>(userBoxId);
    return box;
  }

//! Add Product Model To DB ---> Hive
  Future<void> storeDataLocally(
      {required String userBoxId, required LocalProduct localProduct}) async {
    var box = await createBoxDb(userBoxId);
    await box.put(localProduct.id, localProduct);
  }

  //! get All Data from Local DB -->Hive
  Future<List<LocalProduct>> getAllDataFromLocal(
      {required String userBoxId}) async {
    var box = await createBoxDb(userBoxId);
    return box.values.toList() as List<LocalProduct>;
  }

  //!deleteItemByIndex
  void deleteItemFromLocal(
      {required String userBoxId, required LocalProduct localProduct}) async {
    var box = await createBoxDb(userBoxId);
    await box.delete(localProduct.id);
  }

  //! check if the movie is in Local list or not
  Future<bool> checkProductIsExist(
      {required String userBoxId, required LocalProduct localProduct}) async {
    var box = await createBoxDb(userBoxId);
    return box.containsKey(localProduct.id);
  }

  //!Create Hive Box Database
  Future<void> clearBoxDb({required String userBoxId}) async {
    createBoxDb(userBoxId).then((box) => box.clear());
  }
}
