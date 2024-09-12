{ pkgs, channel ? "stable", ... }: {
  packages = [
    pkgs.cargo
    pkgs.rustc
  ];
  bootstrap = ''
    cargo new "$WS_NAME"
    cd "$WS_NAME"

    cargo add leptos -F csr ${if channel == "nightly" then "-F nightly" else ""}

    mkdir -p ".idx/"
    mkdir -p "public/"

    cp -f ${./dev.nix} ".idx/dev.nix"

    sed -i -e "s/\$WS_NAME/$WS_NAME/g" -e 's/\$CHANNEL/${channel}/g' ".idx/dev.nix"

    cp -f ${./app/index.html} "index.html"
    cp -f ${./app/main.rs} "src/main.rs"
    cp -f ${./app/robots.txt} "public/robots.txt"
    cp -f ${./app/rust-analyzer.toml} "rust-analyzer.toml"

    printf "/.idx/rustup\n/dist\n" >> ".gitignore"

    cd ..
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"
  '';
}
