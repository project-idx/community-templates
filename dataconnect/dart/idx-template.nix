/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs,  ... }: {
  packages = [
    pkgs.nodejs_20
    pkgs.wget
    pkgs.postgresql
    pkgs.curl
    pkgs.gnutar
    pkgs.xz
    pkgs.git
    pkgs.nodePackages.pnpm
    pkgs.busybox
  ];

  bootstrap = ''
    mkdir -p "$out"/.idx
    install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    cp ${./installDeps.sh} "$out"/installDeps.sh
    chmod +x "$out"/installDeps.sh
    initdb -D "$out"/local
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
