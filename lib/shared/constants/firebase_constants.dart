class FirebaseErrors {
  ///create account messages
  static const String weakPassword = 'weak-password';
  static const String usedEmail = 'email-already-in-use';
}

class FirebasePaths {
  // static const String usersPath='users';
  static String getUsersPath(String id) => 'users/$id';
}
