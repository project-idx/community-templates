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

rm -rf ./postgres-test && \
idx-template \
  /home/user/idx/postgres \
  --output-dir /home/user/idx/postgres-test -a '{ "template": "basic" }'

cp -r ${./${template}}/.[!.]* ${./${template}}/..?* "$out"
*/

{pkgs, template, ... }: {
  packages = [
    pkgs.postgresql
  ];

  bootstrap = ''
    mkdir "$out"
    initdb -D "$out"/local
    cp -r ${./basic}/.[!.]* ${./basic}/..?* "$out"
    mv ${./videos.json} "$out"/videos.json
    chmod -R u+w "$out"
  '';
}