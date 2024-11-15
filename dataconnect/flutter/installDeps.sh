#!/bin/bash
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
while [ ! -f ./.firebaserc ]
do
    echo "============================================================================================================================================="
    echo "Couldn't find .firebaserc file. Please open the Data Connect Extension and Connect a firebase project. Waiting 5s before checking again"
    echo "============================================================================================================================================="
    sleep 5s # Waits 5 seconds.
done

projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
while [ -z "$projectId" ] ||  [ "$projectId" == "monospace-2" ]
do
    echo "========================================================================================================================================================="
    echo "Couldn't find project ID in .firebaserc. Please open the Firebase Data Connect Extension and Connect a firebase project. Waiting 5s before checking again"
    echo "========================================================================================================================================================="
    sleep 5s # Waits 5 seconds.
    projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
done
echo "Using ProjectID: $projectId"
dart pub global activate flutterfire_cli
export PATH=~/.global_modules/bin:$PATH
endName=$(ls android/app/src/main/kotlin/com/example)
rm lib/firebase_options.dart
flutterfire configure -y -a com.example.$endName
flutter pub get
firebase dataconnect:sdk:generate
