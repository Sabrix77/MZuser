import 'package:flutter/material.dart';

import '../../../model/category.dart';

class HomeCategoryItem extends StatelessWidget {
  Category category;
  String? selectedCategory;

  HomeCategoryItem({required this.category, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
            image: AssetImage(category.image), fit: BoxFit.fill),
        border: selectedCategory == category.id
            ? Border.all(width: 2, color: Colors.blue)
            : Border.all(width: 1, color: Colors.black12),
      ),
      child: Center(
        child: Text(category.name, style: const TextStyle(letterSpacing: 1.4)),
      ),
    );
  }
}
