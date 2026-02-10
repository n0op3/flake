{ pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    waybar
    fastfetch
    git-credential-manager
    hyprlock
    swaylock-effects
    hypridle
    hyprshutdown
    brightnessctl
    hyprsunset
    vial
    qmk
    qmk-udev-rules
    mpv
    playerctl
    wl-clipboard
    clipse
    rofi-power-menu
    unipicker
    pwvucontrol
    swww
    vesktop
    discord-canary
    stow
    starship
    kitty
    pywal16
    bibata-cursors
    papirus-icon-theme
    pywalfox-native
    tidal-hifi
    cava
    grimblast
    eog
    heroic
    wineWowPackages.stable
    winetricks
    mako
    libnotify
    millennium-steam
    prismlauncher
    davinci-resolve
    networkmanager_dmenu
    dragon-drop
    ffmpeg
    gimp
    inkscape
    signal-desktop-bin
    blueberry
    fd
    just
    go
    gcc
    opencode
    thunar
    russ
    smassh
    pamixer
    python3
    pkg-config
    rustup
    glrnvim
    vscode-extensions.vadimcn.vscode-lldb
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture # Game capture on Wayland
      wlrobs # Wayland window capture
    ];
  };

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
  };

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-emoji ];
    configPath = "";
  };

  services.kdeconnect.enable = true;

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
