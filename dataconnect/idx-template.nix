/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/test -a '{}'

*/
{pkgs, ... }: {
  packages = [
    pkgs.postgresql
  ];

  bootstrap = ''
    mkdir "$out"
    initdb -D "$out"/local
    mkdir "$out"/.idx
    cp -r ${./dev}/* "$out"
    cp ${./dev}/.firebaserc "$out"/.firebaserc
    cp ${./dev}/.graphqlrc.yaml "$out"/.graphqlrc.yaml
    cp ${./dev.nix} "$out"/.idx/dev.nix
    chmod -R u+w "$out"
  '';
}