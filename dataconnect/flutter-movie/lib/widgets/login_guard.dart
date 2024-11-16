import 'package:dataconnect/util/auth.dart';
import 'package:flutter/material.dart';

class LoginGuard extends StatelessWidget {
  const LoginGuard({
    super.key,
    required this.builder,
    this.message,
  });

  final WidgetBuilder builder;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Auth.instance,
      builder: (context, state, _) {
        final isLoggedIn = Auth.instance.isLoggedIn;
        if (!isLoggedIn) {
          if (message == null) {
            return const SizedBox();
          }
          return Text(
            'Please visit the profile page'
            'to log in before $message',
          );
        }
        return builder(context);
      },
    );
  }
}
