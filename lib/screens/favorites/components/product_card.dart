import 'package:flutter/material.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  LocalProduct localProduct;
  Function()? onPressed;

  ProductCard({required this.localProduct, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MainProvider>(context);

    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .pushNamed(ProductDetails.routeName, arguments: localProduct.id),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 180,
                  child: Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const SizedBox(width: 135),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        localProduct.title,
                                        //overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onPressed != null
                                        ? IconButton(
                                            onPressed: onPressed,
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.redAccent,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                                Text(
                                  localProduct.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .color!
                                              .withOpacity(.7)),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 30,
              left: provider.language=='en'?5:null,
              right: provider.language=='en'?null:5,
              child: SizedBox(
                width: 130,
                // color: Colors.red,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/Loading_icon.gif'),
                    image: NetworkImage(localProduct.imageUrl),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
