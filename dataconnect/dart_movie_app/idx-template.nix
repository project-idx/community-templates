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
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./.graphqlrc.yaml} "$out"/.graphqlrc.yaml
    mkdir "$out"/.vscode
    cp ${./.vscode/settings.json} "$out"/.vscode/settings.json
    cp -r ${./dart_movie_app} "$out"
    chmod -R u+w "$out"
  '';
}
