dart pub global activate flutterfire_cli
fail() {
    echo "Unable to log in. Please re-run ./installDeps.sh to configure Flutter for your workstation."
    exit 1
}
firebase login --reauth || fail
flutterfire configure -y -a com.example.blank
