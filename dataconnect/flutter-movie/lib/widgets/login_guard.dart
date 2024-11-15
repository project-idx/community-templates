import 'package:dataconnect/util/auth.dart';
import 'package:flutter/material.dart';

class LoginGuard extends StatefulWidget {
  const LoginGuard({super.key, required this.widgetToGuard, this.message});

  final Widget widgetToGuard;

  final String? message;

  @override
  State<LoginGuard> createState() => _LoginGuardState();
}

class _LoginGuardState extends State<LoginGuard> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    Auth.isLoggedIn().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return widget.widgetToGuard;
    }
    if (widget.message == null) {
      return const SizedBox();
    }
    return Text(
        'Please visit the Profile page to log in before ${widget.message}');
  }
}
