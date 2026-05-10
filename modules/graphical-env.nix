{ inputs, pkgs, ... }:
{
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}; [
      xdg-desktop-portal-hyprland
    ];
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = rec {
        monospace = [
          "JetBrainsMono"
          "Noto Sans Mono"
        ];
        serif = monospace;
        sansSerif = monospace;
      };
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
