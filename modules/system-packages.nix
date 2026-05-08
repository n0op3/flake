{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (btop.override { cudaSupport = true; })
    usermount
    util-linux
    file
    vim
    killall
    wget
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
    tldr
    zip
    jdk21
    vulkan-tools
    vulkan-loader
    powertop
    cachix
    nix-ld
  ];
}
