#!/bin/bash
npm install -g firebase-tools
export PATH=~/.global_modules/bin:$PATH
~/.global_modules/bin/firebase projects:list
dart pub global activate flutterfire_cli
export PATH=~/.global_modules/bin:$PATH
#!/bin/bash
while [ ! -f ./.firebaserc ]
do
    echo "Couldn't find .firebaserc file. Waiting 5s before checking again"
    sleep 5s # Waits 5 seconds.
done

projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
while [ -z "$projectId"]
do
    echo "Couldn't find project ID in .firebaserc. Waiting 5s before checking again"
    sleep 5s # Waits 5 seconds.
    projectId=$(cat ./.firebaserc | grep -o '"default": "[^"]*' |  grep -o '[^"]*$')
done
# TODO(mtewani): Add a check for project ID.
echo "Using ProjectID: $projectId"
flutterfire configure -y -a com.example.blank
flutter pub get
