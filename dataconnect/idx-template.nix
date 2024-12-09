/*

rm -rf ./test && \
idx-template \
  /home/user/community-templates/dataconnect \
  --output-dir /home/user/community-templates/template-test -a '{}'

*/
{pkgs, platform ? "web", appType ? "blank", ... }: {
  packages = [
    pkgs.nodejs_20
  ];

  bootstrap = let 
    platformPrefix = if platform == "web" then "nextjs" else "flutter";
    suffix = if platform == "web" && appType == "quickstart" then "movie-app" else if platform == "flutter" && appType == "quickstart" then "movie" else appType;
    sample = "${platformPrefix}-${suffix}";
    in ''
    mkdir "$out"
    chmod -R u+w "$out"
    mkdir "$out"/.idx
    
    ${
    if sample == "flutter-blank" || sample == "flutter-movie" then "cp -r ${./flutter}/dev.nix \"$out\"/.idx/dev.nix"
      else "cp ${"./" + sample}/dev.nix \"$out\"/.idx/dev.nix"
    }
    
    ${
      if sample == "nextjs-movie-app" then "cp -r ${./nextjs-movie-app}/* \"$out\""
      else if sample == "nextjs-blank" then "cp -r ${./nextjs-blank}/* \"$out\""
      else if sample == "flutter-blank" then "cp -r ${./flutter-blank}/* \"$out\""
      else "cp -r ${./flutter-movie}/* \"$out\""
    }
    chmod -R u+w "$out"
    ${
      if sample == "flutter-blank" || sample == "flutter-movie" then "cp ${./flutter}/installDeps.sh \"$out\"/" else ""
    }
    ${
      if sample == "flutter-blank" || sample == "flutter-movie" then "cp ${./flutter}/Caddyfile \"$out\"/" else ""
    }
    ${
      if sample == "flutter-blank" || sample == "flutter-movie" then "cp ${./flutter}/error_handler.dart \"$out\"/lib/" else ""
    }
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./.graphqlrc.yaml} "$out"/.graphqlrc.yaml
    mkdir "$out"/.vscode
    cp ${./.vscode/settings.json} "$out"/.vscode/settings.json
    chmod -R u+w "$out"
  '';
}
