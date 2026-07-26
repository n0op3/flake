{ inputs, pkgs, ... }:
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

  environment.systemPackages = with pkgs; [
    podman-compose
    winboat
    inputs.vm-curator.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
