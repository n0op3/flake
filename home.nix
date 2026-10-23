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
    manpages.enable = true;
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
    tor-browser
    (pkgs.symlinkJoin {
      name = "blender";
      paths = [ inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/blender \
          --set __NV_PRIME_RENDER_OFFLOAD 1 \
          --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
          --set __GLX_VENDOR_LIBRARY_NAME nvidia \
          --set __VK_LAYER_NV_optimus NVIDIA_only
      '';
    })
    aw-qt
    awatcher
    libinput-gestures
    tidal-hifi
    sone
    inputs.hiresTi.packages.${pkgs.stdenv.hostPlatform.system}.default
    seahorse
    tuxedo
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
