{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics =  {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
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

  environment.shellAliases = { "nrs" = "sudo nixos-rebuild switch"; };

  environment.systemPackages = with pkgs; [
    vim
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
    yazi
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "lavender";
    })
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}

