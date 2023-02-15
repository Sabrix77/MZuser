import 'package:hive/hive.dart';

part 'local_product.g.dart';

@HiveType(typeId: 1)
class LocalProduct {
  //! Hive Local Model
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String date;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  String description; //! <-----

  LocalProduct({
    required this.id,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.description,
  });
}
