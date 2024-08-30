/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs,  ... }: {
  packages = [];

  bootstrap = ''
    mkdir "$out"
    cp ${./flutter_linux_3.22.2-stable.tar.xz} "$out/flutter_linux_3.22.2-stable.tar.xz"
    echo "$WS_NAME" >> $out/.ws_name
    echo "$out/.." >> $out/.out_name
    printenv >> .env
    mkdir "$out"/.idx
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
