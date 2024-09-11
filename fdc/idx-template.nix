{pkgs, project-id ? "DEFAULT", ... }: {
  packages = [];

  bootstrap = ''
    mkdir "$out"
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix
    cp -r ${./app}/* "$out"/app
    cp -r ${./dataconnect}/* "$out/dataconnect"
    cp ${./.firebaserc} "$out"/.firebaserc
    cp ${./firebase.json} "$out"/.firebase.json
    chmod -R u+w "$out"
    sed -i 's/example-project/${project-id}/' "$out"/.firebaserc
  '';
}
