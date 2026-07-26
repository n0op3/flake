{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.aagl.nixosModules.default ];

  config = lib.mkIf config.nihonConfig.gaming.enable {
    nix.settings = inputs.aagl.nixConfig;
    programs.anime-game-launcher.enable = true;
  };
}
