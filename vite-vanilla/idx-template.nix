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

/*
  idx-template \
  --output-dir /home/user/idx/laravel-tailwind-vite-test \
  -a '{}' \
  --workspace-name 'app' \
  /home/user/idx/laravel-tailwind-vite \
  --failure-report

*/
{ pkgs, language ? "js", ... }: {
  packages = [
    pkgs.nodejs_20
  ];
  bootstrap = ''
    mkdir -p "$WS_NAME"
    npm create -y vite@latest "$WS_NAME" -- --template ${if language == "ts" then "vanilla-ts" else "vanilla"}
    mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./icon.svg} "$WS_NAME/.idx/icon.svg"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"
    cd "$out"; npm install --package-lock-only --ignore-scripts
  '';
}