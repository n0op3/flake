{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprshutdown
    hyprpicker
    hyprsunset
    swaylock-effects
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
