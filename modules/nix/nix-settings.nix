{ settings, pkgs, ... }: {
  nix.settings = {
    cores = 10;
    max-jobs = "auto";

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "googleearth-pro-7.3.7.1155"
      "openssl-1.1.1w"
      "pnpm-10.29.2"
      "electron-40.10.5"
    ];
  };

  programs.nh = {
    enable = true;
    flake = "/home/${settings.username}/flake";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Any missing dynamic libraries for unpackaged programs
    # go here, NOT in environment.systemPackages

    # Core C/C++ runtime (rustup toolchain needs)
    stdenv.cc.cc.lib # libstdc++, libgcc_s
    zlib
    openssl

    # Bevy: input (gamepad/device detection)
    udev
    libudev-zero # alt udev impl some distros/binaries expect; harmless to include alongside udev

    # Bevy: audio backend
    alsa-lib

    # Bevy: windowing/graphics (Wayland, since you're on Hyprland)
    wayland
    libxkbcommon
    vulkan-loader

    # Bevy: windowing fallback (X11, in case anything still probes for it)
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

    # General
    fontconfig
    freetype
  ];
}
