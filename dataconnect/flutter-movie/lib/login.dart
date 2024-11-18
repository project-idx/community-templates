import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final String link =
      "https://firebase.corp.google.com/project/${Firebase.app().options.projectId}/authentication/providers";
  Future<void> logIn() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = GoRouter.of(context);
    messenger.showSnackBar(const SnackBar(content: Text('Signing In')));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _username.text,
        password: _password.text,
      );
      if (mounted) {
        navigator.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String message = e.message!;
        bool shouldLaunch = e.code.contains('operation-not-allowed');
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: Column(children: [
                    Text('There was an error when logging in user. $message'),
                    shouldLaunch
                        ? TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(link),
                                  webOnlyWindowName: '_blank');
                            },
                            child: const Text(
                                'Click here to check if you have the email/password login sign in enabled in the Firebase Console.'))
                        : const SizedBox()
                  ]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(),
                    ),
                    controller: _username,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    obscureText: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    controller: _password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          logIn();
                        }
                      },
                      child: const Text('Sign In')),
                  const Text("Don't have an account?"),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/signup');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
