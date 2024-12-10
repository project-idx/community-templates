import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/auth_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  signUp() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Signing Up')));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _username, password: _password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(_name);
      await MoviesConnector.instance.upsertUser(username: _username).execute();
      if (mounted) {
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String message = e.code.contains('configuration-not-found')
            ? 'Email/Password authentication has not been enabled'
            : e.message!;
        bool shouldLaunch = e.code.contains('operation-not-allowed') ||
            e.code.contains('configuration-not-found');
        AuthDialog.showAuthDialog(context, message, shouldLaunch);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder()),
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
                                hintText: "Password",
                                border: OutlineInputBorder()),
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
                              child: const Text('Submit'))
                        ],
                      ))
                ],
              ))),
    );
  }
}
