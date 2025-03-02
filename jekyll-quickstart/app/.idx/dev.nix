# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    # Jekyll requirements
    pkgs.ruby
    pkgs.bundler
    pkgs.gcc
    pkgs.gnumake
    pkgs.jekyll
  ];
  # Sets environment variables in the workspace
  env = { };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [ ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        web = {
          # Build the site and make it available on a local server
          # nix-shell -p bundler --run "bundle exec jekyll serve"
          command = [
            "nix-shell"
            "-p"
            "bundler"
            "--run"
            "bundle exec jekyll serve --port $PORT"
          ];
          manager = "web";
          env = {
            PORT = "$PORT";
          };
        };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Create a new Jekyll site at project root position
        jekyll-create = "jekyll new . --force";
        # Install gems into local
        gem-install = "nix-shell -p bundler --run \"bundle install --gemfile=Gemfile\"";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ ".idx/dev.nix" "README.md" ];
      };
      # Runs when the workspace is (re)started
      onStart = { };
    };
  };
}
