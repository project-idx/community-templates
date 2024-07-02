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