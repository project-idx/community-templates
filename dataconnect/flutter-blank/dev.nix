# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {

processes = {
    startProxy = ''
        pnpm install && pnpm run start:proxy
      '';     
      
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
  ];
  
  # Sets environment variables in the workspace
  env = {
    POSTGRESQL_CONN_STRING = "postgresql://user:mypassword@localhost:5432/dataconnect?sslmode=disable";
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
        installSdk = ''
          chmod +x ./installDeps.sh
          ./installDeps.sh
        '';
        writeEnv = {
          command = "echo \"HOST=$WEB_HOST\" > .env";
        };
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