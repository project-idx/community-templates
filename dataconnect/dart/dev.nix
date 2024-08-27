# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {



services = {
      postgres = {
        extensions = ["pgvector"];
        enable = true;
      };
    };
  # Which nixpkgs channel to use.
   channel = "stable-24.05"; # or "unstable"
  
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs_20
    pkgs.nodePackages.pnpm
    pkgs.jdk17
    pkgs.unzip
    pkgs.flutter
  ];
  
  # Sets environment variables in the workspace
  env = {
    POSTGRESQL_CONN_STRING = "postgresql://user:mypassword@localhost:5432/dataconnect?sslmode=disable";
    PATH = ["/home/user/.pub-cache/bin"];
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"


    extensions = let firebaseExt = pkgs.fetchurl {
    url =
      "https://firebasestorage.googleapis.com/v0/b/getting-started-dart-storage.appspot.com/o/firebase-vscode-0.5.7-dart3.vsix?alt=media&token=7019cd11-d7d0-4039-b72d-426d7cb00d02";
    hash = "sha256-/3ltrQCiwYm8WnOmNEGLwwOsli0broJhuR7hFKNGAMI=";
    name = "firebase.vsix";
  }; in [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
      "mtxr.sqltools"
      "mtxr.sqltools-driver-pg"
      "GraphQL.vscode-graphql-syntax"
      "${firebaseExt}"
    ];
    
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        installSdk = ''
          npm install
          node download.js
        '';
        setupFlutterfire =''
         dart pub global activate flutterfire_cli
          export PATH="$PATH:/home/user/.pub-cache/bin"
        '';
        installDependencies = ''
        cd dart_movie_app
        flutter pub get
        '';
        postgres = ''
            psql --dbname=postgres -c "ALTER USER \"user\" PASSWORD 'mypassword';"
            psql --dbname=postgres -c "CREATE DATABASE dataconnect;"
            psql --dbname=dataconnect -c "CREATE EXTENSION vector;"
          '';
      };
      onStart = {
        start = ''
          cd proxy-web
          npm install
          node proxy.js
        '';
      };
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "9003"];
          manager = "flutter";
        };
        android = {
          command = ["flutter" "run" "--machine" "-d" "android" "-d" "localhost:5555"];
          manager = "flutter";
        };
      };
    };
  };

}