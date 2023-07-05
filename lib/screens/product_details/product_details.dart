import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/home/sections/home_product_item.dart';
import 'package:mzady/screens/product_details/product_details_vavigator.dart';
import 'package:mzady/screens/product_details/product_details_vm.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
import 'package:mzady/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

import '../settings/settings_sections/delivery_policy_section.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = 'productsDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState
    extends BaseView<ProductDetails, ProductDetailsViewModel>
    implements ProductDetailsNavigator {
  final bidController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rebuilded = false;

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  ProductDetailsViewModel initViewModel() {
    return ProductDetailsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    ///for same screen with diffrent access places (home,favorite)
    ///not passing the product itself
    String productId = ModalRoute.of(context)?.settings.arguments as String;
    if(!rebuilded) viewModel.getProductDetails(productId);
    rebuilded=true;

    var provider = Provider.of<MainProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: SafeArea(
        child: Consumer<ProductDetailsViewModel>(
          builder: (_, productViewModel, __) {
            if (productViewModel.errorMessage != null) {
              return Scaffold(
                body: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(AppStrings.someThingWentWrong),
                      SizedBox(height: 10),
                      Text(AppStrings.productHasDeleted),
                    ],
                  ),
                ),
              );
            }
            if (productViewModel.product == null ||
                productViewModel.similarProducts == null ||
                productViewModel.biddersName == null) {
              return const Scaffold(
                body: Center(
                  ///TODO  convert to shimmer
                  child: CircularProgressIndicator(),
                ),
              );
            }

            LocalProduct localProduct = LocalProduct(
              id: viewModel.product!.id,
              title: viewModel.product!.title,
              date: viewModel.product!.endDate,
              imageUrl: viewModel.product!.imgUrl,
              description: viewModel.product!.description,
            );
            return Scaffold(
                body: Stack(
                  children: [
                    Stack(
                      children: [
                        FadeInImage(
                          placeholder: const AssetImage(
                              'assets/images/Loading_icon.gif'),
                          image: NetworkImage(productViewModel.product!.imgUrl),
                          height: MediaQuery.of(context).size.height * .6,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ))
                      ],
                    ),
                    DraggableScrollableSheet(
                        minChildSize: .4,
                        maxChildSize: .7,
                        initialChildSize: .6,
                        builder: (context, scrollController) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                )),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    thickness: 3,
                                    indent: 100,
                                    endIndent: 100,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          productViewModel.product!.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        onPressed: () {
                                          bool isSelected = provider
                                              .isProductSelected(localProduct);
                                          if (isSelected) {
                                            provider
                                                .deleteLocalItem(localProduct);
                                          } else {
                                            provider
                                                .setLocalProduct(localProduct);
                                          }
                                        },
                                        icon: provider
                                                .isProductSelected(localProduct)
                                            ? const Icon(Icons.favorite,
                                                color: Colors.redAccent,
                                                size: 30)
                                            : const Icon(Icons.favorite_border,
                                                color: Colors.black, size: 30),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    color: Colors.grey[300],
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                        productViewModel.product!.category,
                                        style: const TextStyle(
                                            color: Colors.black45)),
                                  ),

                                  const SizedBox(height: 6),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                  const SizedBox(height: 14),

                                  Text(
                                    AppLocalizations.of(context)!.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    productViewModel.product!.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: Colors.black54),
                                  ),
                                  const SizedBox(height: 6),
                                  // Text('Price start with: 250LE',
                                  //     style: TextStyle(color: Colors.black45)),
                                  const SizedBox(height: 10),
                                  Text(
                                      '${AppLocalizations.of(context)!.weight} ${productViewModel.product!.weight}',
                                      style: const TextStyle(
                                          color: Colors.black45)),
                                  const SizedBox(height: 16),

                                  Row(
                                    children: [
                                      Text(
                                          '${AppLocalizations.of(context)!.ends_at} ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(color: Colors.grey)),
                                      Text(
                                          '${productViewModel.endDate.toString().substring(0, 10)} @ 12:00 pm',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color: Colors.redAccent)),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                      thickness: 1, color: Colors.black12),
                                  const SizedBox(height: 6),

                                  DeliveryPolicySection(iconNotNeeded: true),
                                  const Divider(
                                      thickness: 1, color: Colors.black12),
                                  const SizedBox(height: 12),
                                  Text(
                                    AppLocalizations.of(context)!.bid_history,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                      height: 80,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Visibility(
                                        visible: productViewModel
                                                .biddersName!.length >
                                            0,
                                        replacement: const Center(
                                          child: Text(
                                            'No Bidders yet, Be The First',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        child: ListView.separated(
                                            itemCount:
                                                viewModel.biddersName!.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 10),
                                            itemBuilder: (context, index) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      viewModel
                                                          .biddersName![index],
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    Text(
                                                      '${viewModel.biddersBid![index].toString()} LE',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ]);
                                            }),
                                      )),

                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(AppLocalizations.of(context)!.delivery_policy,
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .headline6!.copyWith(color: Colors.black)),
                                  //     const Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                                  //   ],
                                  // ),
                                  const SizedBox(height: 6),
                                  const Divider(
                                      thickness: 1, color: Colors.black12),
                                  const SizedBox(height: 20),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .similar_items,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.black)),
                                  const SizedBox(height: 14),
                                  // Consumer(builder: builder)

                                  SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          viewModel.similarProducts!.length,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 10),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: SizedBox(
                                            width: 130,
                                            // height: ,
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pushNamed(
                                                          ProductDetails
                                                              .routeName,
                                                          arguments: viewModel
                                                              .similarProducts![
                                                                  index]
                                                              .id);
                                                },
                                                child: HomeProductItem(viewModel
                                                    .similarProducts![index])),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                bottomNavigationBar: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (productViewModel.biddersBid!.length > 0)
                            Text('Biggest Bid',
                                style: Theme.of(context).textTheme.caption),
                          if (productViewModel.biddersBid!.length == 0)
                            Text('Initial Bid',
                                style: Theme.of(context).textTheme.caption),
                          Text(
                            productViewModel.product!.biggestBid.last
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Add Your Bid'),
                                    content: Form(
                                      key: _formKey,
                                      child: CustomTextField(
                                        controller: bidController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter your bid';
                                          }
                                          if (int.parse(value) <=
                                              productViewModel
                                                  .product!.biggestBid.last) {
                                            return 'Your Bid must be more than current bid';
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.number,
                                        hint:
                                            'Current Bid Is: ${productViewModel.product!.biggestBid.last} LE',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              viewModel.setNweBidToProduct(
                                                sellerId: productViewModel
                                                    .product!.sellerId,
                                                product:
                                                    productViewModel.product!,
                                                newWinner: provider.user!.id,
                                                newBid: int.parse(
                                                    bidController.text),

                                                // productId: productId,
                                                // winnerId: provider.user!.id,
                                                // lastWinnerId:productViewModel.product!.winnerID.last ,
                                              );
                                            }
                                          },
                                          child: const Text('Bid'))
                                    ],
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize:
                                  const Size.fromHeight(double.infinity),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_bag,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Bid Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
