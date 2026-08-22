{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  programs.virt-manager.enable = true;
  systemd.services.libvirt-guests.enable = false;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };

  virtualisation.podman.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Disable on boot
  systemd.services.docker.wantedBy = lib.mkForce [ ];
  systemd.sockets.docker.wantedBy = [ "sockets.target" ];
  systemd.services.libvirtd.wantedBy = lib.mkForce [ ];
  systemd.sockets.libvirtd.wantedBy = [ "sockets.target" ];
  systemd.sockets.libvirtd-ro.wantedBy = [ "sockets.target" ];
  systemd.sockets.libvirtd-admin.wantedBy = [ "sockets.target" ];

  environment.systemPackages = with pkgs; [
    podman-compose
    winboat
    inputs.vm-curator.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
