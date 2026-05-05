{ pkgs, ... }:
{
  imports = [ ./mcsr/default.nix ];

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
}
