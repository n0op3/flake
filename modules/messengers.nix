{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    simplex-chat-desktop
    discord-canary
    signal-desktop
    vesktop
    inputs.concord.packages.${pkgs.stdenv.hostPlatform.system}.concord
  ];
}
