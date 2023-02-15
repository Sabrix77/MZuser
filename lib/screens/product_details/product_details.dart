import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/product_details/product_details_vavigator.dart';
import 'package:mzady/screens/product_details/product_details_vm.dart';
import 'package:mzady/shared/app_strings.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = 'productsDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState
    extends BaseView<ProductDetails, ProductDetailsViewModel>
    implements ProductDetailsNavigator {
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
    ///to add or remove item to favorite بس لما نعملها بالفايربيز
    // var mainProvider=Provider.of<MainProvider>(context);

    String productId = ModalRoute.of(context)?.settings.arguments as String;
    viewModel.getProductDetails(productId);
    var provider = Provider.of<MainProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: SafeArea(child: Consumer<ProductDetailsViewModel>(
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
          if (productViewModel.product == null) {
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
                        placeholder:
                            const AssetImage('assets/images/Loading_icon.gif'),
                        image: NetworkImage(productViewModel.product!.imgUrl),
                        height: MediaQuery.of(context).size.height * .6,
                        width: double.infinity,
                        fit: BoxFit.fill,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontWeight: FontWeight.w500),
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
                                              color: Colors.redAccent, size: 30)
                                          : const Icon(Icons.favorite_border,
                                              size: 30),
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
                                const Divider(thickness: 1),
                                const SizedBox(height: 14),

                                Text('Description',
                                    style:
                                        Theme.of(context).textTheme.headline6),
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
                                Text(productViewModel.product!.weight ?? '',
                                    style:
                                        const TextStyle(color: Colors.black45)),
                                const SizedBox(height: 16),

                                Row(
                                  children: [
                                    Text('Ends at ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(color: Colors.grey)),
                                    Text(
                                        '${productViewModel.endDate.toString().substring(0, 10)} @ 12:00 pm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.redAccent)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Divider(thickness: 1),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Policy',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const Divider(thickness: 1),
                                const SizedBox(height: 20),
                                Text('Similar Items',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 14),
                                SizedBox(
                                  width: double.infinity,
                                  height: 120,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 100,
                                        height: 120,
                                        color: Colors.grey[400],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 40)
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Biggest Bid',
                            style: Theme.of(context).textTheme.caption),
                        Text(
                          productViewModel.product!.biggestBid.toString(),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(double.infinity),
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
      )),
    );
  }
}
