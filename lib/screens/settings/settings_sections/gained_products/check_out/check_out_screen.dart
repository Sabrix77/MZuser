import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/gained_products/check_out/credit_check_out.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
import 'package:mzady/shared/combonent/main_button.dart';
import 'package:mzady/shared/style/app_theme.dart';
import 'package:provider/provider.dart';

import 'success_order.dart';

class CheckOutScreen extends StatefulWidget {
  static const String routeName = 'CheckOutScreen';

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _newAddressController = TextEditingController();
  String paymentMethod = "cash";
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;

    var provider = Provider.of<MainProvider>(context);
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  // AppLocalizations.of(context)!.shipping_address,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontFamily: 'Tajawal'),
                ),
                SizedBox(height: 4),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.user!.firstName +
                                  ' ' +
                                  provider.user!.lastName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 20),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Add new Address',
                                                      // AppLocalizations.of(context)!.add_new_address,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontFamily:
                                                                  'Tajawal')),
                                                  SizedBox(height: 10),
                                                  Divider(thickness: 1),
                                                  SizedBox(height: 30),
                                                  Text('Address'
                                                      // AppLocalizations.of(context)!.address
                                                      ),
                                                  SizedBox(height: 6),
                                                  CustomTextField(
                                                    controller:
                                                        _newAddressController,
                                                    validator: (value) {},
                                                    hint: provider.user!.address,
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .4,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        //spakety 3l4an n5ls
                                                        //Saving new Address
                                                        FirebaseFirestore.instance
                                                            .collection('users')
                                                            .doc(provider.user!.id)
                                                            .update({
                                                          'address':
                                                              _newAddressController
                                                                  .text
                                                        }).then((value) {
                                                          provider
                                                              .initUserManually();
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                      child: Text('Save'
                                                          // AppLocalizations.of(context)!.save
                                                          )))
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Change',
                                  //AppLocalizations.of(context)!.change,
                                  style: TextStyle(color: Colors.red[300]),
                                )),
                          ],
                        ),
                        if (provider.user!.address.isEmpty)
                          Text(
                            'Oops, you must set your address',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        if (provider.user!.address.isNotEmpty)
                          Text(provider.user!.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Payment Method',
                  // AppLocalizations.of(context)!.payment_method,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontFamily: 'Tajawal'),
                ),
                const SizedBox(height: 10),
                RadioListTile(
                  title: Text(
                    'Cash Payment',
                    // AppLocalizations.of(context)!.cash_payment
                  ),
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: "cash",
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                    'Credit Payment',
                    // AppLocalizations.of(context)!.credit_payment
                  ),
                  value: "credit",
                  groupValue: paymentMethod,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              height: 200,
              width: double.infinity,
              color: Theme.of(context).colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Auction Price',
                            // AppLocalizations.of(context)!.order_price,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const Spacer(),
                          Text(product.biggestBid.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 20)),
                          const SizedBox(width: 2),
                          Text('LE',
                              // AppLocalizations.of(context)!.rial,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 13))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Price',
                            // AppLocalizations.of(context)!.delivery_price,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const Spacer(),
                          Text('free',
                              // AppLocalizations.of(context)!.free,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 20, fontWeight: FontWeight.w400)),
                          const SizedBox(width: 2),
                          //Text('ريال',style:Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Summary',
                            // AppLocalizations.of(context)!.summary,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const Spacer(),
                          Text(product.biggestBid.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 24)),
                          const SizedBox(width: 2),
                          Text('LE',
                              // AppLocalizations.of(context)!.rial,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 13))
                        ],
                      ),
                      MainButton(
                        onTap: () {
                          if (paymentMethod == 'cash') {
                            updateAuctionPaymentMethodState(product.id);
                          } else {
                            ///credit card screen
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(CreditCheckOut.routeName,arguments: product);
                          }
                        },
                        text: 'Confirm Checkout',
                        // AppLocalizations.of(context)!.submit_order,
                      )
                    ]),
              )),
        ),
        Visibility(
            visible: _isLoading,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(.3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child:CircularProgressIndicator(),),
            )),
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
        .update({'paymentMethod': 'Cash'});
    Future.delayed(Duration(seconds: 4),()=>{
      Navigator.pushReplacementNamed(context, SuccessOrder.routeName)
    });
  }
}
