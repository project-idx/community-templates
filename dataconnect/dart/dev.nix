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
        build-flutter = ''
          cd /home/user/dart_movie_app/android

          ./gradlew \
            --parallel \
            -Pverbose=true \
            -Ptarget-platform=android-x86 \
            -Ptarget=/home/user/dart_movie_app/lib/main.dart \
            -Pbase-application-name=android.app.Application \
            -Pdart-defines=RkxVVFRFUl9XRUJfQ0FOVkFTS0lUX1VSTD1odHRwczovL3d3dy5nc3RhdGljLmNvbS9mbHV0dGVyLWNhbnZhc2tpdC85NzU1MDkwN2I3MGY0ZjNiMzI4YjZjMTYwMGRmMjFmYWMxYTE4ODlhLw== \
            -Pdart-obfuscation=false \
            -Ptrack-widget-creation=true \
            -Ptree-shake-icons=false \
            -Pfilesystem-scheme=org-dartlang-root \
            assembleDebug

          # TODO: Execute web build in debug mode.
          # flutter run does this transparently either way
          # https://github.com/flutter/flutter/issues/96283#issuecomment-1144750411
          # flutter build web --profile --dart-define=Dart2jsOptimization=O0 

          adb -s localhost:5555 wait-for-device
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