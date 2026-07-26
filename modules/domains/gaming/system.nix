{ inputs, ... }: {
  imports = [
    inputs.mcsr-nixos.nixosModules.waywall
    ./mcsr/system.nix
    ./an-anime-game.nix
  ];
}
