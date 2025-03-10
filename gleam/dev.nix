{
  "pkgs ? import <nixpkgs> {} // { allowUnfree = true; }": {
    "devShell": pkgs.mkShell {
      "buildInputs": [
        pkgs.gleam
      ]
    }
  }
}
