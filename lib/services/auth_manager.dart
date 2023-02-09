import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static Future<UserCredential> createUserAccount(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('===========================');
      print(e.toString());
      throw e;
      // if (e.code ==FirebaseErrors.weakPassword) {
      //   print('The password provided is too weak.');
      // } else if (e.code == FirebaseErrors.usedEmail) {
      //   print('The account already exists for that email.');
      // }
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> logInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
