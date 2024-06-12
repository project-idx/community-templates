/*
rm -rf /home/user/idx/dart-static-server-test && idx-template \
--output-dir /home/user/idx/dart-static-server-test \
-a '{}' \
--workspace-name 'app' \
/home/user/idx/dart-static-server \
--failure-report
*/
{ pkgs, ... }: {
  packages = [
    pkgs.dart
  ];
  bootstrap = ''    
    mkdir "$out"
    mkdir -p "$out/.idx/"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
    chmod -R +w "$out"
    cp -r ${./dev} "$out"
  '';
}