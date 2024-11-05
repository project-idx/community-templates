import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<UserCredential> logIn() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "movie_app_clone@clone.com", password: "password");
    return FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "movie_app_clone@clone.com", password: "password");
    // Trigger the authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication? googleAuth =
    //     await googleUser?.authentication;

    // // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
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
                logIn().then(
                  (value) {
                    if (context.mounted) {
                      context.goNamed('Home');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
