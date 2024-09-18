{ pkgs, ... }: 
  let firebase-ext = pkgs.fetchurl {
    url =
      "https://firebasestorage.googleapis.com/v0/b/firemat-preview-drop/o/vsix%2Ffirebase-vscode-0.5.3.vsix?alt=media&token=f9ebbddf-b09f-4aae-b8c5-7ebe7ae95725";
    hash = "sha256-W30ofDjr611EKwZf3lAq+u+mf6Ao0Z1IMrVhoxZtCQo=";
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
          update-firebase = "npm install -g firebase-tools";
          update-dataconnect = "cd webapp && npm i firebase@dataconnect-preview";
          postgres = ''
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
