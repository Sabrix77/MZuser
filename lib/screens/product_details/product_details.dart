import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = 'productsDetails';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Stack(
                children: [
                  Image(
                    image: const AssetImage('assets/images/testproduct.jpg'),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .6,
                  ),
                  Positioned(
                      top: 20,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ))
                ],
              ),
              DraggableScrollableSheet(
                  minChildSize: .4,
                  maxChildSize: .6,
                  initialChildSize: .5,
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
                              indent: 80,
                              endIndent: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Product Title heitle heitle here',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border, size: 30),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(6),
                              child: Text('Phones',
                                  style: TextStyle(color: Colors.black45)),
                            ),

                            const SizedBox(height: 6),
                            const Divider(thickness: 1),
                            const SizedBox(height: 14),

                            Text('Description',
                                style: Theme.of(context).textTheme.headline6),
                            const SizedBox(height: 10),
                            Text(
                              'this description is manually added in next to do we will do refactor for products collection  in firestore and retrive this desc',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: Colors.black54),
                            ),
                            const SizedBox(height: 6),
                            // Text('Price start with: 250LE',
                            //     style: TextStyle(color: Colors.black45)),
                            const SizedBox(height: 10),
                            Text('Weight: 500g',
                                style: TextStyle(color: Colors.black45)),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Text('Ends at ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: Colors.grey)),
                                Text('23-2-2023 @ 1:12pm',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Delivery Policy',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Divider(thickness: 1),
                            const SizedBox(height: 20),
                            Text('Similar Items',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 100,
                                    height: 120,
                                    color: Colors.grey[400],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 80)
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Biggest Bid',
                        style: Theme.of(context).textTheme.caption),
                    Text(
                      '1750LE',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(double.infinity),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: 20,
                        ),
                        SizedBox(width: 10),
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
          )
          // bottomNavigationBar: BottomNavigationBar(
          //
          // ),
          ),
    );
  }
}
