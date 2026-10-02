{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    discord-canary
    signal-desktop
    vesktop
    element-desktop
    inputs.concord.packages.${pkgs.stdenv.hostPlatform.system}.concord
  ];
}
