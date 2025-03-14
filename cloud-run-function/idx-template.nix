{ pkgs, functionName ? "my_cloud_function", ... }:

{
  bootstrap = ''
    mkdir -p "$out"
    cp -r ${./.}/* "$out"
    chmod -R u+w "$out"
    rm -rf "$out/.git" "$out/idx-template.json" "$out/idx-template.nix"
  '';
}