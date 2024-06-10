/*
idx-template \
--output-dir /home/user/idx/hono-test \
-a '{ "manager": "bun" }' \
--workspace-name 'app' \
/home/user/idx/hono \
--failure-report
*/
{ pkgs, manager ? "npm", ... }: {
  packages = [
    pkgs.nodejs_20
    pkgs.bun
  ];
  bootstrap = ''
    ${
      if manager == "npm" then "npm create hono@latest \"$WS_NAME\" -- --template nodejs --pm npm --install"
      else if manager == "bun" then "bun create hono@latest \"$WS_NAME\" --template nodejs --pm bun --install"
      else "npm create hono@latest \"$WS_NAME\" -- --template nodejs --pm npm --install"
    }
    
    mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    
    file="$WS_NAME/src/index.ts"
    sed -i 's/const port = 3000/const port = parseInt(process.env.PORT || '9002', 10)/g' "$file"

    mv "$WS_NAME" "$out"
    cd "$out"; npm install --package-lock-only --ignore-scripts
  '';
}