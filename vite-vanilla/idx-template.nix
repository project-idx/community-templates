{ pkgs, language ? "js", ... }: {
  packages = [
    pkgs.nodejs_20
  ];
  bootstrap = ''
    mkdir -p "$WS_NAME"
    npm create -y vite@latest "$WS_NAME" -- --template ${if language == "ts" then "vanilla-ts" else "vanilla"}
    mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./icon.png} "$WS_NAME/.idx/icon.svg"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"
    cd "$out"; npm install --package-lock-only --ignore-scripts
  '';
}