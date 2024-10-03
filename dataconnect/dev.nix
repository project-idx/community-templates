{ pkgs, sample ? "nextjs-email-app", ... }: 
  {
    channel = "stable-24.05";
    packages = [
      pkgs.nodejs_20
    ];
    processes = {
      writeEnv = {
        command = "echo \"HOST=$WEB_HOST\" > .env";
      };
      installDeps = ${if sample == "flutter-blank" then { command = "./installDeps.sh"; } else {}};
    };
    
    env = {
      POSTGRESQL_CONN_STRING = "postgresql://user:mypassword@localhost:5432/dataconnect?sslmode=disable";
      PATH = ["/home/user/.pub-cache/bin"  "/home/user/flutter/bin"];
    };
  
    idx.extensions = [
      "mtxr.sqltools"
      "mtxr.sqltools-driver-pg"
      ${if sample == "flutter-blank" then "Dart-Code.flutter" "Dart-Code.dart-code" else ""}
      "GraphQL.vscode-graphql-syntax"
      "GoogleCloudTools.firebase-dataconnect-vscode"
    ];

    services.postgres = {
      extensions = ["pgvector"];
      enable = true;
    };

    idx = {
      workspace = {
        onCreate = {
          update-firebase = "npm install -g firebase-tools";
          postgres = ''
            psql --dbname=postgres -c "ALTER USER \"user\" PASSWORD 'mypassword';"
            psql --dbname=postgres -c "CREATE DATABASE dataconnect;"
            psql --dbname=dataconnect -c "CREATE EXTENSION vector;"
          '';
          installDeps = ${if sample == "flutter-blank" then "flutter pub get" else "cd webapp && npm i"};
        };
      };
      previews = {
        enable = true;
        previews = if sample == "flutter-blank" then  {
        web = {
          command = ["flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "9003"];
          manager = "flutter";
        };
        android = {
          command = ["flutter" "run" "--machine" "-d" "android" "-d" "emulator-5554"];
          manager = "flutter";
        };
      } else {
          web = {
            command = ["npm" "run" "dev" "--prefix" "./webapp" "--" "--port" "$PORT" "--hostname" "0.0.0.0"];
            manager = "web";
          };
        };
      };
    };
}
