/*
 Copyright 2024 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    
  ];

  # Sets environment variables in the workspace
  env = {
    # You can get a Gemini API key through the IDX Integrations panel to the left!
    POSTGRESQL_CONN_STRING = "postgresql://user:mypassword@localhost:5432/youtube?sslmode=disable";
  };

  services.postgres = {
    enable = true;
  };

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "mtxr.sqltools-driver-pg"
      "mtxr.sqltools"
    ];

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        default.openFiles = [
          "create.sql" "example.sql"
        ];
        # Example: install JS dependencies from NPM
        setup = ''
          initdb -D local
          psql --dbname=postgres -c "ALTER USER \"user\" PASSWORD 'mypassword';"
          psql --dbname=postgres -c "CREATE DATABASE youtube;"
          psql --dbname=youtube -f create.sql
          psql --dbname=youtube -f example.sql
        '';
      };
      # Runs when the workspace is (re)started
      onStart = {
        # typescript-build = "tsc";
      };
    };

    # Enable previews
    previews = {
      enable = true;
      previews = {
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };
      };
    };
  };
}
