{ pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    waybar
    fastfetch
    git-credential-manager
    hyprlock
    hypridle
    brightnessctl
    mpv
    playerctl
    iwgtk
    wl-clipboard
    clipse
    rofi
    rofi-emoji
    rofi-power-menu
    pwvucontrol
    swww
    vesktop
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
    bat
    tmux
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

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
