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

{ pkgs, siteUrl ? "example.com", siteTitle ? "Example", username ? "root", password ? "password", email ? "info@wp-cli.org", ... }: {
  packages = [
    pkgs.go
    pkgs.python3
    pkgs.python311Packages.pip
    pkgs.python311Packages.fastapi
    pkgs.python311Packages.uvicorn
    pkgs.wordpress
    pkgs.sqlite
    pkgs.git
    pkgs.wp-cli
  ];
  bootstrap = ''    
    mkdir "$out"
    mkdir -p "$out/.idx/"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
    wp core download --path="$out"
    cp -r ${./dev}/src/db.php "$out/wp-content"
    cp -r ${./dev}/src/wp-config.php "$out"
    cp -r ${./dev}/README.md "$out/README.md"
    cd "$out"; wp core install --url=${siteUrl} --title=${siteTitle} --admin_user=${username} --admin_password=${password} --admin_email=${email}
    chmod -R +w "$out"
  '';
}
