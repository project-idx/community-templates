import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static Future<bool> isLoggedIn() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user == null) {
      return false;
    }
    try {
      String? idToken = await user.getIdToken();
      return idToken != null;
    } catch (_) {
      return false;
    }
  }

  static getCurrentUser() {
    return FirebaseAuth.instance.authStateChanges().first;
  }
}
