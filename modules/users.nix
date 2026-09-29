{ pkgs, settings, ... }: {
  users.users.${settings.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "render"
      "audio"
      "input"
      "dialout"
      "uinput"
      "libvirtd"
      "wireshark"
      "avahi"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
}
