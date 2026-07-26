{ inputs, ... }: {
  imports = [
    inputs.mcsr-nixos.nixosModules.waywall
    ./mcsr/system.nix
    {
      imports = [ inputs.aagl.nixosModules.default ];
      nix.settings = inputs.aagl.nixConfig;
      programs.anime-game-launcher.enable = true;
    }
  ];
}
