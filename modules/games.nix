{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    heroic
    millennium-steam
    gamemode
    prismlauncher
    smassh
  ];
}
