{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (btop.override { cudaSupport = true; })
    usermount
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
    jdk21
    vulkan-tools
    vulkan-loader
    powertop
    cachix
    nix-ld
    bandwhich
    wineWow64Packages.stable
    winetricks
  ];

  programs.gpu-screen-recorder.enable = true;

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
