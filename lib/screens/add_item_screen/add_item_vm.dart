import 'dart:io';

import 'package:mzady/base.dart';
import 'package:mzady/screens/add_item_screen/add_item_navigator.dart';
import 'package:mzady/services/generic_firebase_utils.dart';
import 'package:mzady/shared/app_strings.dart';

import '../../model/product.dart';
import '../../services/database_utils.dart';

class AddItemViewModel extends BaseViewModel<AddItemNavigator> {
  void addProductToFireStore({
    required String title,
    required String description,
    required int price,
    File? imgFile,
    required String category,
    required String endDate,
    required String sellerId,
    String? weight,
  }) async {
    String documentId = DateTime.now().toIso8601String();
    String imgUrl;
    try {
      if (imgFile != null) {
        navigator!.showLoading(content: AppStrings.uploadingImage);

        imgUrl = await FirebaseUtils.instance.uploadImageToFireStorage(imgFile);

        navigator!.hideDialog();
      } else {
        imgUrl = AppStrings.demoImgUrl;
      }

      Product product = Product(
          id: documentId,
          title: title,
          description: description,
          price: price,
          biggestBid: price,
          imgUrl: imgUrl,
          category: category,
          endDate: endDate,
          sellerId: sellerId,
          weight: weight);

      navigator!.showLoading(content: AppStrings.savingDetails);
      await DatabaseUtils.setProductToFirestore(product);
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.itemHasUploaded, AppStrings.goHome);
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
    }
  }
}
