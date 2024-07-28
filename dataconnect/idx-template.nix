/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs, ... }: {
  packages = [];

  bootstrap = ''
    mkdir "$out"
    mkdir "$out"/.idx
    cp -r ${./nextjs-email-app}/* "$out"
    cp ${./nextjs-email-app}/.firebaserc "$out"/.firebaserc
    cp ${./nextjs-email-app}/.graphqlrc.yaml "$out"/.graphqlrc.yaml
    cp ${./dev.nix} "$out"/.idx/dev.nix
    chmod -R u+w "$out"
  '';
}