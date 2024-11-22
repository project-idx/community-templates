# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  processes = {
    writeEnv = {
      command = "echo \"HOST=$WEB_HOST\" > .env";
    };
  };

  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
 
  
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.nodejs_20
    (pkgs.postgresql_15.withPackages (p: [ p.pgvector ]))
    pkgs.nodePackages.pnpm
    pkgs.jdk17
    pkgs.unzip
    pkgs.caddy
  ];
  
  # Sets environment variables in the workspace
  env = {
    FIREBASE_DATACONNECT_POSTGRESQL_STRING =  "postgresql://user:mypassword@localhost:5432/dataconnect?sslmode=disable";
    PATH = ["/home/user/.pub-cache/bin"  "/home/user/flutter/bin" "./.flutter-sdk/flutter/bin"];
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "mtxr.sqltools"
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
      "mtxr.sqltools-driver-pg"
      "GraphQL.vscode-graphql-syntax"
      "GoogleCloudTools.firebase-dataconnect-vscode"
    ];
    
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        postgres = ''
          psql --dbname=postgres -c "ALTER USER \"user\" PASSWORD 'mypassword';"
          psql --dbname=postgres -c "CREATE DATABASE dataconnect;"
          psql --dbname=dataconnect -c "CREATE EXTENSION vector;"
        '';
        installSdk = ''
          chmod +x ./installDeps.sh
          ./installDeps.sh
        '';
      };
      onStart = {
        startProxy = ''
          caddy run
        '';
      };
     
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # set up a proxy that routes requests from $PORT in IDX to 9003, and any FDC-like queries are automatically rerouted to FDC
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