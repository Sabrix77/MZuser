import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 150,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          ///when he click item it will view productDetails screen
        },
        child: Stack(
          children: [
            Container(height: 150),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 120,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 15,
              bottom: 15,
              child: SizedBox(
                width: 140,
                // color: Colors.red,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/testproduct.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
