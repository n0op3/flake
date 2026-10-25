{ settings, ... }: {
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0 power_level=0
    options iwlmvm power_scheme=1
    options iwlmvm bt_coex_active=1
  '';

  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    hostName = "${settings.hostname}";

    networkmanager = {
      enable = true;
      dns = "none";
      ethernet.macAddress = "permanent";
      wifi = {
        macAddress = "permanent";
        scanRandMacAddress = false;
      };
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    firewall = rec {
      enable = true;
      checkReversePath = "loose";
      trustedInterfaces = [ "enp8s0" ];

      # Minecraft
      allowedTCPPorts = [ 25565 ];

      # Yeelight Station, Minecraft
      allowedUDPPorts = [
        1982
        25565
        4445
      ];

      allowedTCPPortRanges = [
        {
          # KDE Connect
          from = 1714;
          to = 1764;
        }
        {
          # SimpleX Chat
          from = 30000;
          to = 65535;
        }
      ];

      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  programs.wireshark.enable = true;
}
