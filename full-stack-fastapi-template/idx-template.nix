{ pkgs, ... }: {
  packages = [
    pkgs.python3
    pkgs.uv
    pkgs.pipx
  ];
  bootstrap = ''    
    mkdir "$out"
    pipx run copier copy -l https://github.com/fastapi/full-stack-fastapi-template my-awesome-project --trust
    cp -rf ${./.} "$out"
    mkdir -p "$out/.idx/"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
    chmod -R +w "$out"
    rm -rf "$out/.git" "$out/idx-template".{nix,json}
  '';
}