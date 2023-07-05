import 'package:flutter/material.dart';
import 'package:mzady/model/local_product.dart';
import 'package:mzady/model/product.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

class HomeProductItem extends StatefulWidget {
  Product product;

  HomeProductItem(this.product);

  @override
  State<HomeProductItem> createState() => _HomeProductItemState();
}

class _HomeProductItemState extends State<HomeProductItem> {
  @override
  Widget build(BuildContext context) {
    print('====PRODUCT ITEM SCREEN=====');
    LocalProduct localProduct = LocalProduct(
      id: widget.product.id,
      title: widget.product.title,
      date: widget.product.endDate,
      imageUrl: widget.product.imgUrl,
      description: widget.product.description,
    );
    var provider = Provider.of<MainProvider>(context);

    bool isExist = provider.isProductSelected(localProduct);

    return Card(
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/Loading_icon.gif'),
                    image: NetworkImage(widget.product.imgUrl),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),

                Positioned(
                  top: 4,
                  right: 4,
                  child: InkWell(
                    onTap: () async {
                      if (isExist == false) {
                        provider.setLocalProduct(localProduct);
                      } else {
                        provider.deleteLocalItem(localProduct);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black12)),
                      child: Icon(
                        isExist ? Icons.favorite : Icons.favorite_border,
                        size: 26,
                        color: isExist ? Colors.redAccent : Colors.black87,
                        // color: provider.isProductSelected(localProduct)?Colors.red:Colors.black26,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  widget.product.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(

                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('${widget.product.biggestBid.last} ${AppStrings.pounds}')
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}
