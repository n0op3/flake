{ pkgs, ... }:
{
  imports = [ ./mcsr/default.nix ];

  home.packages = with pkgs; [
    lutris-free
    heroic
    millennium-steam
    gamemode
    prismlauncher
    smassh
  ];
}
