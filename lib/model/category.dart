class Category {
  String id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  static List<Category> categories = [
    Category(
        id: 'others',
        name: 'Others',
        image: 'assets/images/categories/others.png'),
    Category(
        id: 'games',
        name: 'Games',
        image: 'assets/images/categories/games.png'),
    Category(
        id: 'toys', name: 'Toys', image: 'assets/images/categories/toys.png'),
    Category(id: 'tvs', name: 'Tvs', image: 'assets/images/categories/tvs.png'),
    Category(
        id: 'phones',
        name: 'Phones',
        image: 'assets/images/categories/phones.png'),
  ];
}
