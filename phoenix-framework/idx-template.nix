{pkgs}: {
  packages = [
    pkgs.elixir
  ];

  bootstrap = ''
    mix archive.install hex phx_new --force
    mix phx.new "$out" --install
    mkdir -p "$out"/.idx
    cp ${./dev.nix} "$out"/.idx/dev.nix

    chmod -R u+w "$out"
    sed -i 's/4000/System.get_env("PORT") || 4000/g' "$out"/config/dev.exs
  '';
}
