#!/bin/bash
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
~/.global_modules/bin/firebase dataconnect:sdk:generate
while [ ! -f ./.firebaserc ]
do
    echo "Couldn't find .firebaserc file.Please open the Data Connect extension and Connect a firebase project. Waiting 5s before checking again"
    sleep 5s # Waits 5 seconds.
done

projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
while [ -z "$projectId" ]
do
    echo "Couldn't find project ID in .firebaserc. Please open the Data Connect plugin and Connect a firebase project. Waiting 5s before checking again"
    sleep 5s # Waits 5 seconds.
    projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
done
dart pub global activate flutterfire_cli
export PATH=~/.global_modules/bin:$PATH

# TODO(mtewani): Add a check for project ID.
echo "Using ProjectID: $projectId"
flutterfire configure -y -a com.example.blank
flutter pub get
firebase dataconnect:sdk:generate
