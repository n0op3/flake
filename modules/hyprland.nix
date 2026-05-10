{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  home.file.".local/share/hyprland/stubs".source = "${
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  }/share/hypr/stubs";

  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprshutdown
    hyprpicker
    hyprsunset
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
