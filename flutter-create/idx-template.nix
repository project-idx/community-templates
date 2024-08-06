{pkgs, sample ? "none", template ? "app", blank ? false, platforms ? "web,android", ...}: let 
  flutter = pkgs.fetchgit {
    url = "https://github.com/flutter/flutter.git";
    hash = "80c2e84975bbd28ecf5f8d4bd4ca5a2490bfc819";
  };
  in {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.flutter
    ];
    bootstrap = ''
        cp -rf ${flutter} flutter
        chmod -R u+w flutter
        PUB_CACHE=/tmp/pub-cache flutter create "$out" --template="${template}" --platforms="${platforms}" ${if sample == "none" then "" else "--sample=${sample}"} ${if blank then "-e" else ""}
        mkdir -p "$out"/.{flutter-sdk,idx}
        mv flutter "$out/.flutter-sdk/flutter"
        echo ".flutter-sdk/flutter" >> "$out/.gitignore"
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}
