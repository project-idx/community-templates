# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.stdenv.cc
    pkgs.rustup
    pkgs.trunk
    pkgs.leptosfmt
  ];
  # Sets environment variables in the workspace
  env = {
    RUSTUP_HOME = "/home/user/$WS_NAME/.idx/rustup";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "rust-lang.rust-analyzer"
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["trunk" "serve" "--port" "$PORT"];
          manager = "web";
        };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        rust-install = "rustup default $CHANNEL; rustup component add rust-analyzer; rustup target add wasm32-unknown-unknown";
        default.openFiles = [ "README.md" "src/main.rs" ];
      };
    };
  };
}
