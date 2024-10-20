{ pkgs, ... }: {
  packages = [
    pkgs.pkgs.lean4
  ];
  bootstrap = ''
    mkdir "$out"
    mkdir "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix
  '';
}