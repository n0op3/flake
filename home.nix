{
  inputs,
  config,
  pkgs,
  ...
}:
{
  home.stateVersion = "25.11";

  imports = [
    ./modules/domains/home.nix
    ./modules/desktop/home.nix
  ];

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  home.packages = with pkgs; [
    droidcam
    v4l-utils
    anki
    libreoffice
    fastfetch
    vial
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
    kdePackages.kdenlive
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
    ungoogled-chromium
    aw-qt
    awatcher
    libinput-gestures
    tidal-hifi
    sone
    inputs.hiresTi.packages.${pkgs.stdenv.hostPlatform.system}.default
    seahorse
    ydotool
    presenterm
    lenovo-legion
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    nativeMessagingHosts = with pkgs; [
      pywalfox-native
    ];
  };

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

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-emoji ];
  };

  home.file.".local/share/icons/default" = {
    source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice/";
    recursive = true;
  };
}
