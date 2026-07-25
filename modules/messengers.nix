{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    discord-canary
    signal-desktop
    vesktop
    inputs.concord.packages.${pkgs.stdenv.hostPlatform.system}.concord
  ];
}
