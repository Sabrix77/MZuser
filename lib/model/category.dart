class Category {
  String id;
  String name;
  String image;

  Category({
    this.id = '',
    required this.name,
    required this.image,
  });

  static List<Category> categories = [
    Category(name: 'Others', image: 'assets/images/categories/others.jpg'),
    Category(name: 'Games', image: 'assets/images/categories/games.jpg'),
    Category(name: 'Tvs', image: 'assets/images/categories/tvs.jpg'),
    Category(name: 'Phones', image: 'assets/images/categories/phones.jpg'),
  ];
}
