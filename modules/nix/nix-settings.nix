{ settings, pkgs, ... }: {
  nix.settings = {
    cores = 3;
    max-jobs = 4;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;

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

    # Bevy: windowing/graphics
    wayland
    libxkbcommon
    vulkan-loader

    # Bevy: windowing fallback (X11, in case anything still probes for it)
    libx11
    libxcursor
    libxrandr
    libxi

    # General
    fontconfig
    freetype
  ];
}
