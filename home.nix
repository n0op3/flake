{
  pkgs,
  inputs,
  settings,
  ...
}:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    anki
    gnome-clocks
    libreoffice
    fastfetch
    vial
    qmk
    qmk-udev-rules
    mpv
    stow
    starship
    kitty
    pywal16
    bibata-cursors
    tidal-hifi
    cava
    scrcpy
    grimblast
    satty
    eog
    inputs.nixpkgs-wine10.legacyPackages.${pkgs.stdenv.hostPlatform.system}.wineWow64Packages.stableFull
    libnotify
    davinci-resolve
    networkmanager_dmenu
    dragon-drop
    ffmpeg
    yt-dlp
    ani-cli
    ytfzf
    file-roller
    ffmpegthumbnailer
    fd
    russ
    pamixer
    qalculate-gtk
    pywalfox-native
    firefoxpwa
    nwg-look
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ungoogled-chromium
    tor-browser
    inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
    aw-qt
    awatcher
    libinput-gestures
  ];

  services.activitywatch = {
    enable = true;
    # watchers.aw-watcher-window-wayland.package = pkgs.aw-watcher-window-wayland;
    watchers.awatcher.package = pkgs.awatcher;
  };

  gtk = rec {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    gtk4.theme = theme;
  };

  catppuccin.enable = true;

  catppuccin.kvantum = {
    enable = true;
    apply = true;
    accent = "lavender";
    flavor = "mocha";
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kvantum";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    DOTNET_ROOT_X64 = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  home.file."/home/${settings.username}/.config/rofi/config.rasi".enable = false;
  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-emoji ];
  };

  services.kdeconnect.enable = false;

  home.file.".local/share/icons/default" = {
    source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice/";
    recursive = true;
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;

      credential = {
        helper = "store";
        credentialStore = "gpg";
      };

      user = {
        name = "n0op3";
        email = "n0op3@proton.me";
      };
    };
  };
}
