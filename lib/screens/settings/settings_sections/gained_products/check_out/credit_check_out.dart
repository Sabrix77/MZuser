import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/check_out/success_order.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
import 'package:mzady/shared/combonent/main_button.dart';
import 'package:mzady/shared/style/app_theme.dart';
import 'package:provider/provider.dart';

class CreditCheckOut extends StatefulWidget {
  static const String routeName = 'CreditCheckOutScreen';

  @override
  State<CreditCheckOut> createState() => _CreditCheckOutState();
}

class _CreditCheckOutState extends State<CreditCheckOut> {
  TextEditingController _nameOnCard = TextEditingController();

  TextEditingController _cardNumber = TextEditingController();

  TextEditingController _expireDate = TextEditingController();

  TextEditingController _cvv = TextEditingController();

  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    Product product = ModalRoute.of(context)?.settings.arguments as Product;

    return Stack(
      children: [
        Scaffold(
          backgroundColor:
              provider.myTheme == MyThemeData.lightTheme ? Color(0xFFF1EFEF) : null,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Payment Card',
                    // AppLocalizations.of(context)!.shipping_address,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: 'Tajawal'),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/payment_card.PNG',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * .6,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Name on Card',
                    // AppLocalizations.of(context)!.payment_method,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(controller: _nameOnCard, validator: (value) {}),
                  const SizedBox(height: 30),
                  Text(
                    'Card Number',
                    // AppLocalizations.of(context)!.payment_method,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(controller: _cardNumber, validator: (value) {}),
                  const SizedBox(height: 30),
                  Text(
                    'Expire Date',
                    // AppLocalizations.of(context)!.payment_method,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(controller: _expireDate, validator: (value) {}),
                  const SizedBox(height: 30),
                  Text(
                    'CVV',
                    // AppLocalizations.of(context)!.payment_method,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(controller: _cvv, validator: (value) {}),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 80,
            width: double.infinity,
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainButton(
                      onTap: () {
                        updateAuctionPaymentMethodState(product.id);
                      },
                      text: 'Confirm Checkout',
                      // AppLocalizations.of(context)!.submit_order,
                    )
                  ]),
            ),
          ),
        ),
        Visibility(
            visible: _isLoading,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(.3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child:CircularProgressIndicator(),),
            ))
      ],
    );
  }
  void updateAuctionPaymentMethodState (
      String productID
      ) {
    setState(() {
      _isLoading=true;
    });
    FirebaseFirestore.instance
        .collection('products')
        .doc(productID)
        .update({'paymentMethod': 'Credit Card'});
    Future.delayed(Duration(seconds: 4),()=>{
      Navigator.pushReplacementNamed(context, SuccessOrder.routeName)
    });
  }
}
