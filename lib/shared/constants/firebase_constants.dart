class FirebaseErrors {
  ///create account messages
  static const String weakPassword = 'weak-password';
  static const String usedEmail = 'email-already-in-use';
}

class FirebasePaths {
  // static const String usersPath='users';
  static String setUserPath(String id) => 'users/$id';

  static String setProductPath(String id) => 'products/$id';

  static String setImagesPath(String imgName) => 'images/$imgName';

  static String usersPath = 'users/';
  static String productsPath = 'products/';
}
