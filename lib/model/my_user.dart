class MyUser {
  String id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String address;

  MyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.address = 'Egypt,',
  });

  MyUser.fromJson(Map<String, dynamic> json, String docId)
      : this(
            id: docId,
            firstName: json['first_name'],
            lastName: json['last_name'],
            email: json['email'],
            phone: json['phone'],
            address: json['address']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
