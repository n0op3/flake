{ pkgs, ... }:
{
  imports = [ ./mcsr/default.nix ];

  home.packages = with pkgs; [
    lutris-unwrapped
    heroic
    millennium-steam
    gamemode
    prismlauncher
    smassh
  ];
}
