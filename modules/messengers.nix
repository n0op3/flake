{ pkgs, ... }:
{
  home.packages = with pkgs; [
    simplex-chat-desktop
    discord-canary
    signal-desktop
    vesktop
  ];
}
