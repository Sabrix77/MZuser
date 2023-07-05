import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/check_out/check_out_screen.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/gained_products_navigator.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/gained_products_vm.dart';
import 'package:mzady/shared/constants/app_strings.dart';
import 'package:mzady/shared/constants/enums.dart';
import 'package:provider/provider.dart';

class OnProgressGainedScreen extends StatefulWidget {
  const OnProgressGainedScreen({Key? key}) : super(key: key);

  @override
  State<OnProgressGainedScreen> createState() => _OnProgressGainedScreenState();
}

class _OnProgressGainedScreenState
    extends BaseView<OnProgressGainedScreen, GainedProductsViewModel>
    implements GainedProductsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  GainedProductsViewModel initViewModel() {
    return GainedProductsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);

    print('===----===========------==');
    print(mainProvider.firebaseUser!.uid);
    print(AuctionState.hasWinner.name);
    viewModel.getProductsWitchUserGain(
        userId: mainProvider.firebaseUser!.uid,
        auctionState: AuctionState.hasWinner.name);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: mainProvider.myTheme == MyThemeData.lightTheme
          //      ? Color(0xFFF1EFEF)
          //      : null,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer<GainedProductsViewModel>(
                    builder: (_, gainedVM, __) {
                      if (gainedVM.products == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (gainedVM.products!.isEmpty) {
                        return const Center(
                          child: Text(
                            AppStrings.winningListIsEmpty,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                      if (gainedVM.errorMessage != null) {
                        return const Center(
                          child: Text(AppStrings.someThingWentWrong),
                        );
                      }
                      DateTime endDate;
                      return ListView.separated(
                        itemCount: gainedVM.products!.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          endDate = DateTime.fromMillisecondsSinceEpoch(
                              int.parse(gainedVM.products![index].endDate));
                          return Card(
                            elevation: 4,
                            child: SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.network(
                                    gainedVM.products![index].imgUrl,
                                    fit: BoxFit.cover,
                                    width: 120,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            gainedVM.products![index].title,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(height: 8),
                                          //Text(endDate.toString().substring(0,10)),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${gainedVM.products![index].biggestBid.toString()} LE',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Expanded(child: SizedBox()),

                                          if (gainedVM.products![index]
                                              .paymentMethod.isEmpty)
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      CheckOutScreen.routeName,
                                                      arguments: gainedVM
                                                          .products![index]);
                                                },
                                                child: const Text(
                                                    'Confirm Paying'),
                                              ),
                                            )
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
      ),
    );
  }
}
