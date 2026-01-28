{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

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
  };

  environment.systemPackages = with pkgs; [
    vim
    gnumake
    lua51Packages.lua
    lua
    luarocks
    git
    fzf
    lsd
    zoxide
    yazi
  ];

  system.stateVersion = "25.11";
}

