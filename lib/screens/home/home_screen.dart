import 'package:flutter/material.dart';
import 'package:mzady/model/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridview = true;
  String demoString =
      'This is a demo descr demo descr demo desr demo descr demo descr iption for product item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('GoBid'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 130,
                      child: ListView.separated(
                        itemCount: Category.categories.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                            ),
                            child: Center(
                              child: Text(Category.categories[index].name,
                                  style: const TextStyle(letterSpacing: 1.4)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Products',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isGridview = !isGridview;
                        });
                      },
                      icon:
                          isGridview ? Icon(Icons.menu) : Icon(Icons.dashboard))
                ],
              ),
              SizedBox(height: 10),
              Visibility(
                visible: isGridview,
                child: GridView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 5),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black45),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xff1A524F4F),
                                ),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: InkWell(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: const Icon(
                                        Icons.favorite_border_outlined),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          demoString.length > 30
                              ? '${demoString.substring(0, 30)}...'
                              : demoString,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text('50 LE'),
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
                    );
                  },
                ),
                replacement: SizedBox(
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 20),
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
                                      border: Border.all(
                                          width: 1, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(0xff1A524F4F),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    right: 4,
                                    child: InkWell(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: const Icon(
                                            Icons.favorite_border_outlined),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              demoString.length > 66
                                  ? '${demoString.substring(0, 65)}...'
                                  : demoString,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Text('50 LE'),
                              ],
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
