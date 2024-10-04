dart pub global activate flutterfire_cli
if ! [ firebase login --reauth ]; then
    echo "Unable to log in. Please re-run ./installDeps.sh to configure Flutter for your workstation."
fi
flutterfire configure -y -a com.example.blank
