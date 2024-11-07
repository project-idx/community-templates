{pkgs, branch ? "stable", repo ? "https://github.com/flutter/flutter", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
    ];
    bootstrap = ''
        mkdir "$out"
        mkdir -p "$out/flutter"
        git clone "${repo}" "$out/flutter/"
        "./$out/flutter/bin" create "$out" --platforms="android,web"
        mkdir "$out"/.idx
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
        chmod -R u+w "$out"
    '';
}