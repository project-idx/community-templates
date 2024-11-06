#!/bin/bash
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
dart pub global activate flutterfire_cli
# Below, we update the path to remove firebase builtin.
flutterfire configure -y -a com.example.blank
