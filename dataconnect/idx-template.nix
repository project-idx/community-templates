/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs, sample ? "nextjs-email-app", projectId ? "FIREBASE_PROJECT_ID", ... }: {
  packages = [
    pkgs.nodejs_20
  ];

  bootstrap = ''
    mkdir "$out"
    mkdir "$out"/.idx
    ${
      if sample == "flutter-blank" then "cp -r ${./flutter-blank}/dev.nix \"$out\"/.idx/dev.nix"
      else "cp ${./dev.nix} \"$out\"/.idx/dev.nix"
    }
    ${
      if sample == "nextjs-email-app" then "cp -r ${./nextjs-email-app}/* \"$out\""
      else if sample == "nextjs-blank" then "cp -r ${./nextjs-blank}/* \"$out\""
      else "cp -r ${./flutter-blank}/* \"$out\""
    }
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./.graphqlrc.yaml} "$out"/.graphqlrc.yaml
    mkdir "$out"/.vscode
    cp ${./.vscode/settings.json} "$out"/.vscode/settings.json
    chmod -R u+w "$out"
    sed -i 's/FIREBASE_PROJECT_ID_HERE/${projectId}/g' "$out"/.firebaserc
    ${
      if sample != "flutter-blank" then "sed -i 's/FIREBASE_PROJECT_ID_HERE/${projectId}/g' \"$out\"/webapp/src/data-connect/index.tsx"
      else ""
    }
  '';
}
