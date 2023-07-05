import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/favorites/components/product_card.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(AppLocalizations.of(context)!.my_favorites,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<MainProvider>(
                builder: (_, mainProvider, __) {
                  if (mainProvider.localProducts.isEmpty) {
                    return const Center(
                        child: Text(
                      'Empty Favorites List',
                      style: TextStyle(fontSize: 20),
                    ));
                  } else {
                    return ListView.separated(
                      itemCount: mainProvider.localProducts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          localProduct: mainProvider.localProducts[index],
                          onPressed: () {
                            mainProvider.deleteLocalItem(
                                mainProvider.localProducts[index]);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
