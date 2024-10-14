#!/bin/bash
is_logged_in=false
dart pub global activate flutterfire_cli
while [ "$is_logged_in" = false ]
do
    firebase login --reauth && is_logged_in=true
done
# Below, we update the path to remove firebase builtin.
flutterfire configure -y -a com.example.blank
