{ pkgs }: {
  packages = [
    pkgs.elan
  ]
  idx = {
    extensions = [
      "leanprover.lean4"
    ];
  };
}