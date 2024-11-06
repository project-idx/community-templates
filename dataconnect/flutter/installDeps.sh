#!/bin/bash
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
~/.global_modules/bin/firebase projects:list
dart pub global activate flutterfire_cli
export PATH=~/.global_modules/bin:$PATH
echo $PATH
flutterfire configure -y -a com.example.blank
