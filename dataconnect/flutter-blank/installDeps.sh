#!/bin/bash
is_logged_in=false
dart pub global activate flutterfire_cli
# while [ "$is_logged_in" = false ]
# do
#     firebase login --reauth && is_logged_in=true
# done
# Below, we update the path to remove firebase builtin.
npm install -g firebase-tools@latest
export PATH=/home/user/flutter/bin/:/opt/code-oss/bin/remote-cli:/home/user/.pub-cache/bin:/home/user/flutter/bin:./.flutter-sdk/flutter/bin:/usr/bin:/usr/sbin:~/.global_modules/bin:/home/user/flutter/bin:/home/user/.pub-cache/bin:/opt/android/platform-tools
flutterfire configure -y -a com.example.blank
