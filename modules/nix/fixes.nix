{
  nixpkgs.overlays = [
    (final: prev: {
      # TODO: remove once nixpkgs adds libgpg-error to vial's extraPkgs
      vial = prev.callPackage ./pkgs/vial.nix { };
    })
  ];
}
