{ inputs, pkgs, ... }:
{
  home.file.".local/share/hyprland/stubs".source = "${
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  }/share/hypr/stubs";

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprshutdown
    hyprpicker
    hyprsunset
    hyprpolkitagent
    swaylock
    waybar
    brightnessctl
    playerctl
    wl-clipboard
    clipse
    rofi-power-menu
    unipicker
    pwvucontrol
    awww
    swaynotificationcenter
  ];
}
