class Product {
  String id;
  String title;
  String description;
  int price;
  int biggestBid;
  String? weight;
  String imgUrl;
  String category;
  String endDate;
  bool available;

  //ممكن نحط انيبلد علشان لما المزاد يخلص يبقي فولص
  // افيلبل دي علشان لما الادمن يوافق ع البرودكت تبقي ترو
  String winnerID;
  String sellerId;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.biggestBid,
    required this.imgUrl,
    required this.category,
    required this.endDate,
    this.available = false,
    this.weight,
    this.sellerId = '',
    this.winnerID = '',
  });

  Product.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          biggestBid: json['biggestBid'],
          imgUrl: json['imgUrl'],
          category: json['category'],
          endDate: json['endDate'],
          available: json['available'],
          weight: json['weight'],
          sellerId: json['sellerId'],
          winnerID: json['winnerID'],
          title: json['title'],
          description: json['description'],
          price: json['price'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biggestBid': biggestBid,
      'imgUrl': imgUrl,
      'category': category,
      'endDate': endDate,
      'available': available,
      'weight': weight,
      'sellerId': sellerId,
      'winnerID': winnerID,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}
