{ pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    stow
    starship
    kitty
    pywal16
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
