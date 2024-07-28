{ pkgs, ... }: 
  let firebase-ext = pkgs.fetchurl {
    url =
      "https://firebasestorage.googleapis.com/v0/b/firemat-preview-drop/o/vsix%2Ffirebase-vscode-0.5.2.vsix?alt=media&token=5e3dec76-eac4-400b-9d7e-b79acec59e71";
    hash = "sha256-dyMPdYyygnx5K+k7Uey2F0xdEfm+5dLyOa+k1dSnAiU=";
    name = "firebase.vsix";
  };
  in {
    channel = "stable-24.05";
    packages = [
      pkgs.nodejs_20
    ];
    
    env = {
      POSTGRESQL_CONN_STRING = "postgresql://user:mypassword@localhost:5432/dataconnect?sslmode=disable";
    };
  
    idx.extensions = [
      "mtxr.sqltools"
      "mtxr.sqltools-driver-pg"
      "GraphQL.vscode-graphql-syntax"
      "${firebase-ext}"
    ];

    services.postgres = {
      extensions = ["pgvector"];
      enable = true;
    };

    idx = {
      workspace = {
        onCreate = {
          setup = "node download.mjs";
          postgres = ''
            initdb -D local
            psql --dbname=postgres -c "ALTER USER \"user\" PASSWORD 'mypassword';"
            psql --dbname=postgres -c "CREATE DATABASE dataconnect;"
            psql --dbname=dataconnect -c "CREATE EXTENSION vector;"
          '';
          npm-install = "npm i --prefix=./webapp";
        };
      };
      previews = {
        enable = true;
        previews = {
          web = {
            command = ["npm" "run" "dev" "--prefix" "./webapp" "--" "--port" "$PORT" "--hostname" "0.0.0.0"];
            manager = "web";
          };
        };
      };
    };
}
