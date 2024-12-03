{ pkgs, ... }: 
  {
    channel = "stable-24.05";
    packages = [
      pkgs.nodejs_20
    ];
    
    idx.extensions = [
      "mtxr.sqltools"
      "mtxr.sqltools-driver-pg"
      "GraphQL.vscode-graphql-syntax"
      "GoogleCloudTools.firebase-dataconnect-vscode"
    ];

    idx = {
      workspace = {
        onCreate = {
          update-firebase = "npm install -g firebase-tools";
        };
      };
    };
}
