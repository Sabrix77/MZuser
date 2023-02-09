import 'package:flutter/material.dart';
import 'package:mzady/shared/combonent/utilis.dart' as utils;

abstract class BaseNavigator {
  void showLoading();

  void hideDialog();

  void showMessage(String message, String positiveBtnTxt);
}

class BaseViewModel<T extends BaseNavigator> extends ChangeNotifier {
  T? navigator;
}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void showLoading() {
    utils.showLoading(context);
  }

  @override
  void hideDialog() {
    utils.hideLoading(context);
  }

  @override
  void showMessage(String message, String positiveBtnTxt) {
    utils.showMessage(context, message, positiveBtnTxt, (context) {
      Navigator.pop(context);
    });
  }
}
