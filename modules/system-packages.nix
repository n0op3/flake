{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (btop.override { cudaSupport = true; })
    efibootmgr
    util-linux
    file
    vim
    killall
    wget
    fzf
    ripgrep
    inputs.kawaru.packages.${pkgs.stdenv.hostPlatform.system}.default
    lsd
    zoxide
    bat
    tmux
    unzip
    duf
    gdu
    imagemagick
    yazi
    trash-cli
    usbutils
    smartmontools
    tree
    man-pages
    tldr
    zip
    vulkan-tools
    vulkan-loader
    powertop
    cachix
    bandwhich
    wineWow64Packages.stable
    winetricks
  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture # Game capture on Wayland
      wlrobs # Wayland window capture
    ];
  };
}
