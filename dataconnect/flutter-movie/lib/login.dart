import 'package:dataconnect/movies_connector/movies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  final String link =
      "https://firebase.corp.google.com/project/${Firebase.app().options.projectId}/authentication/providers";
  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Username", border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
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
                  hintText: "Password", border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
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
            Text('Don\'t have an account?'),
            ElevatedButton(
                onPressed: () {
                  context.go('/signup');
                },
                child: const Text('Sign Up')),
          ],
        ));
  }

  logIn() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Signing In')));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _username, password: _password);
      if (mounted) {
        context.go('/home');
      }
    } catch (_) {
      if (mounted) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: Column(children: [
                    Text('There was an error when creating a user.'),
                    TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(link));
                        },
                        child: Text(
                            'Click here to check if you have the email/password login sign in enabled in the Firebase Console.'))
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
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_buildForm()],
              ))),
    );
  }
}
