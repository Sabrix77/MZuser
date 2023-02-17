import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/favorites/components/product_card.dart';
import 'package:mzady/screens/search/search_navigator.dart';
import 'package:mzady/screens/search/search_vm.dart';
import 'package:mzady/shared/app_strings.dart';
import 'package:mzady/shared/combonent/custom_text_field.dart';
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
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Column(
          children: [
            Container(
              // color: Color(0xfffc6e51),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Center(
                child: CustomTextField(
                  controller: _searchController,
                  borderColor: Colors.black,
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      viewModel.filterProductListByTitle(value);
                    } else {
                      viewModel.clearFilteredList();
                    }
                  },
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hint: 'Search for specific item',
                  validator: (value) => null,
                ),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => viewModel,
              child: Consumer<SearchViewModel>(
                builder: (_, searchVM, __) {
                  if (searchVM.filteredProducts.isEmpty) {
                    //refactor this
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Image.asset(
                          'assets/images/shopingcar.png',
                          fit: BoxFit.fill,
                          opacity: const AlwaysStoppedAnimation(.5),
                        ));
                  }

                  if (searchVM.errorMessage != null) {
                    return const Center(
                      child: Text(AppStrings.someThingWentWrong),
                    );
                  }
                  Product product;
                  LocalProduct asLocalProduct;

                  return Expanded(
                    child: ListView.builder(
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
                          return ProductCard(
                            localProduct: asLocalProduct,
                          );
                        }),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
