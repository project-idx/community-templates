/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs,  ... }: {
  packages = [
    pkgs.wget
    pkgs.postgresql
    pkgs.curl
    pkgs.gnutar
    pkgs.xz
    pkgs.git
    pkgs.busybox
  ];

  bootstrap = let flutter = pkgs.fetchzip {
    url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.3-stable.tar.xz";
    hash = "sha256-j+Jl8Q8Qaj9oJVZ1LNuTuIVxX7ba0f8w38OdS/vvqtA=";
  };  in ''
  cp -rf ${flutter} flutter
  chmod -R u+w flutter
    mkdir -p "$out"/.{flutter-sdk,idx}
    mv flutter "$out/.flutter-sdk/flutter"
    echo ".flutter-sdk/flutter" >> "$out/.gitignore"
    install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    initdb -D "$out"/local
    printenv >> "$out"/.env
    cp ${./dev.nix} "$out"/.idx/dev.nix
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./.graphqlrc.yaml} "$out"/.graphqlrc.yaml
    mkdir "$out"/.vscode
    cp ${./.vscode/settings.json} "$out"/.vscode/settings.json
    cp -r ${./dart_movie_app}/* "$out"
    cp -r ${./dataconnect} "$out/dataconnect"
    cp ${./package.json} "$out/package.json"
    cp ${./download.js} "$out/download.js"
    cp -r ${./proxy-web} "$out/proxy-web"
    chmod -R u+w "$out"
  '';
}
