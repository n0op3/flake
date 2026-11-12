{
  pkgs,
  lib,
  nihonConfig,
  ...
}:
{
  config = lib.mkIf nihonConfig.gaming.enable {
    home.packages = with pkgs; [
      lutris-unwrapped
      heroic
      millennium-steam
      steam-run
      gamemode
      gamescope
      prismlauncher
      smassh
      protonplus
      protontricks
    ];
  };
}
