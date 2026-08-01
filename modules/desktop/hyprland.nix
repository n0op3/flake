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
    swaylock
    waybar
    brightnessctl
    playerctl
    wl-clipboard
    pkgs-unstable.clipse
    rofi-power-menu
    unipicker
    pwvucontrol
    awww
    swaynotificationcenter
  ];
}
