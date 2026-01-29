{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    theme = (pkgs.sleek-grub-theme.override { withStyle = "dark"; });
    timeoutStyle = "hidden";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-lavender";
    wayland.enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  users.users.n0op3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  environment.shellAliases = {
    "nrs" = "sudo nixos-rebuild switch";
    "nrsu" = "sudo nixos-rebuild switch --upgrade";
    "nsp" = "nix-shell -p";
    "nxs" = "nix search nixpkgs";
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "JetBrainsMono" "Noto Sans Mono" ];
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
    };
    packages = with pkgs; [ nerd-fonts.jetbrains-mono noto-fonts-cjk-sans ];
  };

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
    git
    fzf
    ripgrep
    lsd
    zoxide
    bat
    tmux
    duf
    gdu
    yazi
    sleek-grub-theme
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "lavender";
    })
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}

