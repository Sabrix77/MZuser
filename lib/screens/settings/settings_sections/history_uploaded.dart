import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base.dart';
import '../../../model/product.dart';
import '../../../provider/main_provider.dart';
import '../../../services/database_utils.dart';
import '../../../shared/app_strings.dart';

class HistoryUploaded extends StatefulWidget {
  @override
  State<HistoryUploaded> createState() => _HistoryUploadedState();
}

class _HistoryUploadedState extends State<HistoryUploaded> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(UploadedScreen.routeName);
      },
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.shopping_cart_sharp),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Uploaded Products',
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadedScreen extends StatefulWidget {
  static const String routeName = 'UploadedHistory';

  @override
  State<UploadedScreen> createState() => _UploadedScreenState();
}

class _UploadedScreenState
    extends BaseView<UploadedScreen, HistoryUploadedViewModel>
    implements HistoryUploadedNavigator {
  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    viewModel.getProductsWitchUserUpload(mainProvider.firebaseUser!.uid);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 60, right: 10, left: 10, bottom: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uploaded Products',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<HistoryUploadedViewModel>(
                  builder: (_, uploadedVM, __) {
                    if (uploadedVM.products == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (uploadedVM.products!.isEmpty) {
                      return const Center(
                        child: Text(
                          // AppStrings.winningListIsEmpty,
                          'No Items yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    if (uploadedVM.errorMessage != null) {
                      return const Center(
                        child: Text(AppStrings.someThingWentWrong),
                      );
                    }
                    DateTime endDate;
                    return ListView.separated(
                      itemCount: uploadedVM.products!.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        endDate = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(uploadedVM.products![index].endDate));
                        return Card(
                          elevation: 8,
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.network(
                                  uploadedVM.products![index].imgUrl,
                                  fit: BoxFit.cover,
                                  width: 120,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          uploadedVM.products![index].title,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 8),
                                        //Text(endDate.toString().substring(0,10)),
                                        const SizedBox(height: 8),
                                        Text(
                                            '${uploadedVM.products![index].biggestBid.toString()} LE',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HistoryUploadedViewModel initViewModel() {
    return HistoryUploadedViewModel();
  }
}

abstract class HistoryUploadedNavigator implements BaseNavigator {}

class HistoryUploadedViewModel extends BaseViewModel<HistoryUploadedNavigator> {
  List<Product>? products;

  String? errorMessage;

  void getProductsWitchUserUpload(String userId) async {
    try {
      products = await DatabaseUtils.getProductsWitchUserUpload(userId);
    } catch (e) {
      errorMessage = AppStrings.someThingWentWrong;
      print('------>ERROR IN HistoryUploadingViewModel:: $e');
    }
    notifyListeners();
  }
}
