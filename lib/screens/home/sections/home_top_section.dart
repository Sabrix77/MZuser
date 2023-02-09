import 'package:flutter/material.dart';

import '../../../model/category.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Categories',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            width: double.infinity,
            height: 130,
            child: ListView.separated(
              itemCount: Category.categories.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(width: 1, color: Colors.black12),
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
    );
  }
}
