#!/bin/bash
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
~/.global_modules/bin/firebase dataconnect:sdk:generate
while [ ! -f ./.firebaserc ]
do
    echo "============================================================================================================================================="
    echo "Couldn't find .firebaserc file. Please open the Data Connect extension and Connect a firebase project. Waiting 5s before checking again"
    echo "============================================================================================================================================="
    sleep 5s # Waits 5 seconds.
done

projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
while [ -z "$projectId" ]
do
    echo "============================================================================================================================================="
    echo "Couldn't find project ID in .firebaserc. Please open the Data Connect plugin and Connect a firebase project. Waiting 5s before checking again"
    echo "============================================================================================================================================="
    sleep 5s # Waits 5 seconds.
    projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
done
echo "Using ProjectID: $projectId"
dart pub global activate flutterfire_cli
export PATH=~/.global_modules/bin:$PATH
flutterfire configure -y -a com.example.blank
flutter pub get
firebase dataconnect:sdk:generate
