{pkgs, sample ? "none", template ? "app", blank ? false, platforms ? "web,android", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.flutter
    ];
    bootstrap = ''
        PUB_CACHE=/tmp/pub-cache flutter create "$out" --template="${template}" --platforms="${platforms}" ${if sample == "none" then "" else "--sample=${sample}"} ${if blank then "-e" else ""} --project-name=$WS_NAME
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
    '';
}