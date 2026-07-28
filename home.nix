{
  inputs,
  settings,
  pkgs,
  ...
}:

{
  home.stateVersion = "25.11";

  imports = [
    ./modules/domains/home.nix
    ./modules/desktop/home.nix
  ];

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
    jj-starship
    kitty
    pywal16
    pywalfox-native
    inputs.themecord.packages.${pkgs.stdenv.hostPlatform.system}.default
    bibata-cursors
    cava
    scrcpy
    grimblast
    satty
    eog
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
    firefoxpwa
    nwg-look
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ungoogled-chromium
    tor-browser
    inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
    aw-qt
    awatcher
    libinput-gestures
    sone
    inputs.hiresTi.packages.${pkgs.stdenv.hostPlatform.system}.default
    seahorse
    tuxedo
    ydotool
  ];

  services.activitywatch = {
    enable = true;
    watchers.awatcher.package = pkgs.awatcher;
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
}
