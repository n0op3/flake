{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-lavender";
    wayland.enable = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [
        "JetBrainsMono"
        "Noto Sans Mono"
      ];
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];
  };
}
