{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprshutdown
    hyprpicker
    hyprsunset
    waybar
    brightnessctl
    playerctl
    wl-clipboard
    clipse
    rofi-power-menu
    unipicker
    pwvucontrol
    swww
    swaynotificationcenter
  ];
}
