{ pkgs, lib, ... }:
{
  programs.hyprland.enable = true;

  programs.silentSDDM = {
    enable = true;
    theme = "nord";
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositorCommand = "${lib.getExe' pkgs.kdePackages.kwin "kwin_wayland"} --drm --no-lockscreen --no-global-shortcuts --locale1";
    package = pkgs.kdePackages.sddm;
    extraPackages = [
      pkgs.kdePackages.layer-shell-qt
    ];
    settings = {
      General = {
        InputMethod = "qtvirtualkeyboard";
      };
    };
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
