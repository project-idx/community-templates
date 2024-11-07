import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> signInWithGoogleOnWeb() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // Once signed in, return the UserCredential
    try {
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } catch (_) {
      showFirebaseAlert();
    }
  }

  Future<void> signInWithGoogleOnMobile() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (_) {
      showFirebaseAlert();
    }
  }

  void showFirebaseAlert() {
    String text = kIsWeb
        ? "Add ${Uri.base.host} to your list of OAuth redirect providers here: https://console.firebase.google.com/project/_/authentication/settings"
        : """Did you add your SHA1 key to your app in the console?
        You can get your key by running the following in your android directory: 
        ./gradlew signingReport
        """;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Firebase Authentication'),
          content: Text('There was an error trying to authenticate. $text'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void logIn() async {
    if (kIsWeb) {
      await signInWithGoogleOnWeb();
    } else {
      await signInWithGoogleOnMobile();
    }
    if (mounted) {
      context.goNamed('Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Center(
        child: Row(
          children: [
            TextButton(
              child: const Text("Sign in"),
              onPressed: () {
                logIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
