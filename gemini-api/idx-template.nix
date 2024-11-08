{ pkgs, environment ? "open-ai-node", ... }: {
    packages = if environment == "open-ai-node" then [ pkgs.nodejs_20 ] else [];
  bootstrap = ''
    mkdir "$out"
    cp -rf ${./.}/${environment}/* "$out"
    mkdir "$out/.idx"
    cp -rf ${./.}/${environment}/.idx "$out"
    chmod -R u+w "$out"
  '';
}