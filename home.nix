{ pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    waybar
    git-credential-manager
    hyprlock
    hypridle
    brightnessctl
    mpv
    playerctl
    iwgtk
    clipse
    rofi
    rofi-emoji
    pwvucontrol
    swww
    stow
    starship
    kitty
    pywal16
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
