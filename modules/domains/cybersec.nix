{
  config,
  lib,
  pkgs,
  settings,
  ...
}:
{
  config = lib.mkIf config.nihonConfig.cybersec.enable {
    users.users.${settings.username}.extraGroups = [
      "wireshark"
    ];

    environment.systemPackages = with pkgs; [
      binaryninja-free
      tor-browser
      ghidra
      nmap
      tcpdump
      nettools
      wireshark
      termshark
    ];
  };
}
