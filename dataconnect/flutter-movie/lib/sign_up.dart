import 'package:dataconnect/movies_connector/movies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _name = '';
  final String link =
      "https://firebase.corp.google.com/project/${Firebase.app().options.projectId}/authentication/providers";
  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Email", border: OutlineInputBorder()),
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
              enableSuggestions: false,
              decoration: const InputDecoration(
                  hintText: "Name", border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();
                  }
                },
                child: Text('Submit'))
          ],
        ));
  }

  signUp() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Signing Up')));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _username, password: _password);
      await MoviesConnector.instance
          .upsertUser(username: _username, name: _name)
          .execute();
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: Column(children: [
                    Text('There was an error when signing up.'),
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
