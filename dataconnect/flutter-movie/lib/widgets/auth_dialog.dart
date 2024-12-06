import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AuthDialog {
  static final String link =
      "https://console.firebase.google.com/project/${Firebase.app().options.projectId}/overview/authentication/providers";
  static showAuthDialog(
      BuildContext context, String message, bool shouldLaunch) {
    List<Widget> content = [const SizedBox()];
    if (shouldLaunch) {
      content = [
        Link(
            uri: Uri.parse(link),
            target: LinkTarget.blank,
            builder: (context, followLink) {
              return TextButton(
                  onPressed: followLink,
                  child: const Text(
                      'Click here to go to the Firebase Console and enable Email/Password Auth.'));
            })
      ];
    }

    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Login Error'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('There was an error when logging in: $message'),
                ...content
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
