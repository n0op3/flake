{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

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

  services.pipewire.enable = true;

  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "/run/current-system/sw/share"
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
    adwaita-icon-theme
    hicolor-icon-theme
  ];

  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

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
