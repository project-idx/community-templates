{pkgs, sample ? "none", template ? "app", blank ? false, platforms ? "web,android" ...}: let
  flutter = pkgs.fetchzip {
    url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.3-stable.tar.xz";
    hash = "sha256-j+Jl8Q8Qaj9oJVZ1LNuTuIVxX7ba0f8w38OdS/vvqtA=";
  };
  in {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
    ];
    bootstrap = ''
        cp -rf ${flutter} flutter
        chmod -R u+w flutter
        PUB_CACHE=/tmp/pub-cache ./flutter/bin/flutter create "$out" --template="${template}" --platforms="${platforms}" ${if sample == "none" then "" else "--sample=${sample}"} ${if blank then "-e" else ""}
        mkdir -p "$out"/.{flutter-sdk,idx}
        mv flutter "$out/.flutter-sdk/flutter"

        echo ".flutter-sdk/flutter" >> "$out/.gitignore"
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}