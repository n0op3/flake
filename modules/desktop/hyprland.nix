{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.file.".local/share/hyprland/stubs".source = "${
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  }/share/hypr/stubs";

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprmon
    hyprshutdown
    hyprpicker
    hyprsunset
    hyprpolkitagent
    inputs.hyprquickframe.packages.${pkgs.stdenv.hostPlatform.system}.default
    quickshell
    swaylock
    waybar
    brightnessctl
    playerctl
    wl-clipboard
    pkgs-unstable.clipse
    inputs.fsel.packages.${pkgs.stdenv.hostPlatform.system}.default
    rofi-power-menu
    unipicker
    pwvucontrol
    awww
    swaynotificationcenter
  ];
}
