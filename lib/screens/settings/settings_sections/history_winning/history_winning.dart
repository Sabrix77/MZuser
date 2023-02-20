import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/shared/app_strings.dart';
import 'package:provider/provider.dart';

import '../../../../model/product.dart';
import '../../../../services/database_utils.dart';

class HistoryWinning extends StatefulWidget {
  const HistoryWinning({Key? key}) : super(key: key);

  @override
  State<HistoryWinning> createState() => _HistoryWinningState();
}

class _HistoryWinningState extends State<HistoryWinning> {
  @override
  Widget build(BuildContext context) {
    // var mainProvider = Provider.of<MainProvider>(context,listen: false);
    // print('IM IN HISTORY WINNING');
    // viewModel.getProductWitchUserWin(mainProvider.firebaseUser!.uid);

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(WinningScreen.routeName);
      },
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.shopping_cart_sharp),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Wining Products',
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

class WinningScreen extends StatefulWidget {
  static const String routeName = 'winningScreen';

  @override
  _WinningScreenState createState() => _WinningScreenState();
}

class _WinningScreenState
    extends BaseView<WinningScreen, HistoryWinningViewModel>
    implements HistoryWinningNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  HistoryWinningViewModel initViewModel() {
    return HistoryWinningViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    viewModel.getProductWitchUserWin(mainProvider.firebaseUser!.uid);
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
                'Winning Products',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<HistoryWinningViewModel>(
                  builder: (_, winningVM, __) {
                    if (winningVM.products == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (winningVM.products!.isEmpty) {
                      return const Center(
                        child: Text(
                          AppStrings.winningListIsEmpty,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    if (winningVM.errorMessage != null) {
                      return const Center(
                        child: Text(AppStrings.someThingWentWrong),
                      );
                    }
                    DateTime endDate;
                    return ListView.separated(
                      itemCount: winningVM.products!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        endDate = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(winningVM.products![index].endDate));
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
                                  winningVM.products![index].imgUrl,
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
                                          winningVM.products![index].title,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 8),
                                        //Text(endDate.toString().substring(0,10)),
                                        const SizedBox(height: 8),
                                        Text(
                                            '${winningVM.products![index].biggestBid.toString()} LE',
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

abstract class HistoryWinningNavigator implements BaseNavigator {}

class HistoryWinningViewModel extends BaseViewModel<HistoryWinningNavigator> {
  List<Product>? products;

  String? errorMessage;

  void getProductWitchUserWin(String userId) async {
    try {
      products = await DatabaseUtils.getProductsWitchUserWin(userId);
    } catch (e) {
      errorMessage = AppStrings.someThingWentWrong;
      print('------>ERROR IN HistoryWinningViewModel:: $e');
    }
    notifyListeners();
  }
}
