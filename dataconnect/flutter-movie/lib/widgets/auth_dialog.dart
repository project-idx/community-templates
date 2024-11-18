import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthDialog {
  static final String link =
      "https://firebase.corp.google.com/project/${Firebase.app().options.projectId}/authentication/providers";
  static showAuthDialog(
      BuildContext context, String message, bool shouldLaunch) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Login Error'),
              content: Column(children: [
                Text('There was an error when logging in user. $message'),
                shouldLaunch
                    ? const Text('Open the app in a new tab:')
                    : const SizedBox(),
                shouldLaunch
                    ? Image.asset('assets/open-in-new-tab.png')
                    : const SizedBox(),
                shouldLaunch
                    ? TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(link),
                              webOnlyWindowName: '_blank');
                        },
                        child: const Text(
                            'Click here to enable Firebase Auth in the Firebase Console.'))
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
