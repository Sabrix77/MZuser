import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/category.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/home/home_navigator.dart';
import 'package:mzady/screens/home/home_vm.dart';
import 'package:mzady/screens/home/sections/home_category_item.dart';
import 'package:mzady/screens/home/sections/home_product_item.dart';
import 'package:mzady/shared/combonent/shimmer_skelton.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../product_details/product_details.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  bool isGridview = true;
  List<Category> categories = Category.categories.reversed.toList();

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    //viewModel.getAllConfirmedProducts();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    print('==============>${mainProvider.user?.isAdmin}');
    print('===========IM IN HOME Screen');
    viewModel.getAllConfirmedProducts();

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: RefreshIndicator(
        onRefresh: () async {
          viewModel.getAllConfirmedProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('GoBid'),
            iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),

          ),
          // drawer: kIsWeb? Drawer(
          //   child: Column(
          //     children: [
          //       Container(
          //         height: 200,
          //         child: Image.asset('assets/images/logo.jpg',fit: BoxFit.contain,),
          //       ),
          //       SizedBox(height: 20),
          //       CustomBodyDrawer(),
          //     ],
          //   ),
          // ):null,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.categories,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 130,
                          child: ListView.separated(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // viewModel
                                  //     .getProductsListByCategory(categories[index].id);
                                  viewModel.getProductsListByCategory(
                                      categories[index].id);
                                },
                                child: Consumer<HomeViewModel>(
                                  builder: (_, homeVM, __) {
                                    return HomeCategoryItem(
                                        category: categories[index],
                                        selectedCategory:
                                            homeVM.selectedCategory);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.products,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isGridview = !isGridview;
                            });
                          },
                          icon: isGridview
                              ? const Icon(Icons.menu)
                              : const Icon(Icons.dashboard))
                    ],
                  ),
                  Consumer<HomeViewModel>(
                    builder: (_, homeViewModel, __) {
                      if (homeViewModel.products == null) {
                        return showHomeProductShimmer();
                      }
                      if (homeViewModel.products!.isEmpty) {
                        //change this ui
                        return const Center(
                          child: Text('It seem that No products yet'),
                        );
                      }
                      return GridView.builder(
                        itemCount: homeViewModel.products!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // crossAxisCount: isGridview ? 2 : 1,
                          crossAxisCount: isGridview ? 2:1,//kIsWeb ?5:2 : kIsWeb?3:1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          // childAspectRatio: isGridview ? .75 : 1.2,
                          childAspectRatio: isGridview ? .75 : 1.2,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(ProductDetails.routeName,
                                      arguments:
                                          homeViewModel.products![index].id);
                            },
                            child:
                                HomeProductItem(homeViewModel.products![index]),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showHomeProductShimmer() {
    return GridView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:  kIsWeb ?5:2 ,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: .75,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(.25),
            highlightColor: Colors.white.withOpacity(.6),
            child: ShimmerSkelton(
                width: double.infinity, height: double.infinity));
      },
    );
  }

  Widget testWidget() {
    return ListView.separated(
      itemCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff1A524F4F),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all()),
                          child: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(''
                  // demoString.length > 66
                  //     ? '${demoString.substring(0, 65)}...'
                  //     : demoString,
                  // style: const TextStyle(
                  //     fontSize: 18, fontWeight: FontWeight.w400),
                  ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('50 LE'),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
