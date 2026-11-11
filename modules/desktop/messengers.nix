{ pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop
    simplex-chat-desktop
    vesktop
    element-desktop
  ];
}
