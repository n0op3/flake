{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    btop
    killall
    clang
    gnumake
    lua51Packages.lua
    lua
    luarocks
    cargo
    fzf
    ripgrep
    lsd
    zoxide
    bat
    tmux
    unzip
    duf
    gdu
    yazi
    trash-cli
    usbutils
    nettools
    tree
    man-pages
    git-filter-repo
    tokei
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "lavender";
    })
  ];
}
