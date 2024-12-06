import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/auth_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  Future<void> logIn() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = GoRouter.of(context);
    messenger.showSnackBar(const SnackBar(content: Text('Signing In')));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _username.text,
        password: _password.text,
      );
      final isLoggedIn =
          await MoviesConnector.instance.getCurrentUser().execute();
      if (isLoggedIn.data.user == null) {
        await MoviesConnector.instance
            .upsertUser(username: _username.text, name: _username.text)
            .execute();
      }
      if (mounted) {
        navigator.go('/home');
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
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
