import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../product_details/product_details.dart';

class ProductsViewSection extends StatelessWidget {
  ProductsViewSection({Key? key}) : super(key: key);
  String demoString =
      'This is a demo descr demo descr demo desr demo descr demo descr iption for product item';

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2 / 3),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(ProductDetails.routeName);
          },
          child: Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black26, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff1A524F4F),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.black12)),
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        demoString.length > 30
                            ? '${demoString.substring(0, 30)}...'
                            : demoString,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [const Text('50 LE')],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
