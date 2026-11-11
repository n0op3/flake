{ inputs, pkgs, ... }:
{
  home.file.".config/hypr/nix-plugins.lua".text = ''
    return {
      "${inputs.gloview.packages.${pkgs.stdenv.hostPlatform.system}.gloview}/lib/libgloview.so",
    }
  '';

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
    inputs.hyprquickframe.packages.${pkgs.stdenv.hostPlatform.system}.default
    quickshell
    waybar
    brightnessctl
    playerctl
    wl-clipboard
    clipse
    unipicker
    pwvucontrol
    qpwgraph
    awww
    swaynotificationcenter
  ];
}
