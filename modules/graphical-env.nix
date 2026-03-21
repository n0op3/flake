{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
  ];

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
