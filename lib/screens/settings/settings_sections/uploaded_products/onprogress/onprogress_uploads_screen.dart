import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/uploaded_products/uploaded_products_navigator.dart';
import 'package:mzady/shared/constants/app_strings.dart';
import 'package:mzady/shared/constants/enums.dart';
import 'package:provider/provider.dart';

import '../uploaded_products_vm.dart';

class OnProgressUploadsScreen extends StatefulWidget {
  const OnProgressUploadsScreen({Key? key}) : super(key: key);

  @override
  State<OnProgressUploadsScreen> createState() =>
      _OnProgressUploadsScreenState();
}

class _OnProgressUploadsScreenState
    extends BaseView<OnProgressUploadsScreen, UploadedProductsViewModel>
    implements UploadedProductsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  UploadedProductsViewModel initViewModel() {
    return UploadedProductsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    viewModel.getProductsWitchUserUpload(
        userId: mainProvider.firebaseUser!.uid,
        auctionState: AuctionState.confirmed.name);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        //  backgroundColor: mainProvider.myTheme==MyThemeData.lightTheme?Color(0xFFF1EFEF):null,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  const SizedBox(height: 20),
              Expanded(
                child: Consumer<UploadedProductsViewModel>(
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
}
