#!/bin/bash
dart pub global activate flutterfire_cli
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
# Below, we update the path to remove firebase builtin.
flutterfire configure -y -a com.example.blank
