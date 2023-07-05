import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mzady/screens/layout/home_layout.dart';

class SuccessOrder extends StatefulWidget {
  const SuccessOrder({Key? key}) : super(key: key);
  static const String routeName = 'SuccessOrder';

  @override
  _SuccessOrderState createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/success_order.png'),
          Text(
            'تم استقبال طلبكم بنجاح',
            style: TextStyle(fontSize: 18),
          ),
          Text('يمكنك متابعة الطلب من خلال رسائل الدعم'),
          SizedBox(height: 60),
          Text('شكراً لإستخدامك تطبيقنا', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
