/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs, sample ? "nextjs-email-app", ... }: {
  packages = [];

  bootstrap = ''
    mkdir "$out"
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix
    ${
      if sample == "nextjs-email-app" then "cp -r ${./nextjs-email-app}/* \"$out\""
      else "cp -r ${./nextjs-blank}/* \"$out\""
    }
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./.graphqlrc.yaml} "$out"/.graphqlrc.yaml
    chmod -R u+w "$out"
  '';
}
