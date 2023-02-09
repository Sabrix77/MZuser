import 'package:flutter/material.dart';
import 'package:mzady/screens/home/sections/home_top_section.dart';
import 'package:mzady/screens/home/sections/products_view_section.dart';

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
        title: const Text('GoBid'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTopSection(),
              const SizedBox(height: 20),
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
                      icon: isGridview
                          ? const Icon(Icons.menu)
                          : const Icon(Icons.dashboard))
                ],
              ),
              Visibility(
                visible: isGridview,
                replacement: SizedBox(
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
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
                                      color: const Color(0xff1A524F4F),
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
                            const SizedBox(height: 6),
                            Text(
                              demoString.length > 66
                                  ? '${demoString.substring(0, 65)}...'
                                  : demoString,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
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
                  ),
                ),
                child: ProductsViewSection(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
