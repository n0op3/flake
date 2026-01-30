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
    brightnessctl
    wlsunset
    mpv
    playerctl
    wl-clipboard
    clipse
    rofi
    rofi-emoji
    rofi-power-menu
    pwvucontrol
    swww
    vesktop
    discord-canary
    stow
    starship
    kitty
    pywal16
    bibata-cursors
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
    steam
    safe-rm
    davinci-resolve
    networkmanager_dmenu
    dragon-drop
    ffmpeg
    signal-desktop-bin
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

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
