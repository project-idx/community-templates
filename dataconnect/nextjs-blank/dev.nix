{ pkgs, ... }: 
  {
    channel = "stable-24.05";
    packages = [
      pkgs.nodejs_20
    ];
    
    env = {
      FIREBASE_DATACONNECT_POSTGRESQL_STRING =  "postgresql://user:mypassword@localhost:5432/dataconnect?sslmode=disable";
    };
  
    idx.extensions = [
      "mtxr.sqltools"
      "mtxr.sqltools-driver-pg"
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
          npm-install = "cd webapp && npm i";
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
