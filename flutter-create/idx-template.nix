{pkgs, sample ? "none", template ? "app", blank ? false, platforms ? "web,android", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
    ];
    bootstrap = ''
        git clone --depth 1 -b stable https://github.com/flutter/flutter.git
        yes | ./flutter/bin/flutter doctor --android-licenses
        ./flutter/bin/flutter doctor
        chown -R root:root flutter
        chmod -R u+w flutter
        PUB_CACHE=/tmp/pub-cache ./flutter/bin/flutter create "$out" --template="${template}" --platforms="${platforms}" ${if sample == "none" then "" else "--sample=${sample}"} ${if blank then "-e" else ""}
        mkdir -p "$out"/.{flutter-sdk,idx}
        mv flutter "$out/.flutter-sdk/flutter"
        echo ".flutter-sdk/flutter" >> "$out/.gitignore"
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}
