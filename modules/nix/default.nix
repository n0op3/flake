{ ... }: {
  imports = [
    ./nix-settings.nix
    ./cachix.nix
    ./cleanup.nix
    ./overlays.nix
  ];
}
