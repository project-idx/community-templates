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
--output-dir /home/user/idx/react-router-test \
-a '{ "template": "library" }' \
--workspace-name 'react-router-test' \
/home/user/community-templates/react-router \
--failure-report
*/
{ pkgs, template ? "default", ... }: {
  packages = [
    pkgs.nodejs_20
  ];
  bootstrap = ''
    mkdir -p "$WS_NAME/.idx/"
    cp -rf ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    
    if [ "${template}" == "library" ]; then
      cp -rf ${./library}/* "$WS_NAME/"
    else
      # https://github.com/remix-run/react-router-templates
      npx create-react-router@latest --template remix-run/react-router-templates/${template} --yes --no-install --no-git-init "$WS_NAME"
    fi

    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"
  '';
}