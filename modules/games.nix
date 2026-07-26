{
  pkgs,
  lib,
  nihonConfig,
  ...
}:
{
  imports = [ ./mcsr/default.nix ];

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
    ];
  };
}
