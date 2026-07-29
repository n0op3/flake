{
  pkgs,
  lib,
  nihonConfig,
  ...
}:
{
  imports = [ ./mcsr/home.nix ];

  config = lib.mkIf nihonConfig.gaming.enable {
    home.packages = with pkgs; [
      lutris-unwrapped
      heroic
      millennium-steam
      steam-run
      gamemode
      prismlauncher
      smassh
      vinegar
      protonplus
      protontricks
    ];
  };
}
