import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/favorites/components/product_card.dart';
import 'package:mzady/screens/search/search_navigator.dart';
import 'package:mzady/screens/search/search_vm.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
import 'package:mzady/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseView<SearchScreen, SearchViewModel>
    implements SearchNavigator {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.getAllProducts();
  }

  @override
  SearchViewModel initViewModel() {
    return SearchViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);

    return SafeArea(
      child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: CustomTextField(
                  controller: _searchController,
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      viewModel.filterProductListByTitle(value);
                    } else {
                      viewModel.clearFilteredList();
                    }
                  },
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                  hint: 'Search for specific item',
                  validator: (value) => null,
                ),
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context) => viewModel,
                child: Consumer<SearchViewModel>(
                  builder: (_, searchVM, __) {
                    if (searchVM.filteredProducts.isEmpty) {
                      //refactor this
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        children: [
                          SizedBox(height: 100),
                          SizedBox(
                              child: Image.asset(
                                'assets/images/searching.png',
                                // fit: BoxFit.fill,
                                opacity: const AlwaysStoppedAnimation(.5),
                              )),
                        ],
                      );
                    }

                    if (searchVM.errorMessage != null) {
                      return const Center(
                        child: Text(AppStrings.someThingWentWrong),
                      );
                    }
                    Product product;
                    LocalProduct asLocalProduct;

                    return ListView.builder(
                        itemCount: searchVM.filteredProducts.length,
                        itemBuilder: (context, index) {
                          product = searchVM.filteredProducts[index];
                          asLocalProduct = LocalProduct(
                            id: product.id,
                            title: product.title,
                            date: product.endDate,
                            imageUrl: product.imgUrl,
                            description: product.description,
                          );
                          return Padding(
                            padding:EdgeInsets.symmetric(horizontal: 20),
                            child: ProductCard(
                              localProduct: asLocalProduct,
                            ),
                          );
                        });
                  },
                ),
              ),
            )
          ],
        )

    );
  }
}
