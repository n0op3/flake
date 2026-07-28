{ pkgs, settings, ... }: {
  users.users.${settings.username}.extraGroups = [
    "wireshark"
  ];

  environment.systemPackages = with pkgs; [
    nmap
    tcpdump
    nettools
    wireshark
    termshark
  ];
}
