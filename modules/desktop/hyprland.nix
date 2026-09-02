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

  home.file.".config/hypr/nix-plugins.lua".text = ''
    return {
     "${
       inputs.hyprcapture.packages.${pkgs.stdenv.hostPlatform.system}.hyprcapture
     }/lib/libhyprcapture.so",
    }
  '';

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprmon
    hyprshutdown
    hyprpicker
    hyprsunset
    hyprpolkitagent
    quickshell
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
