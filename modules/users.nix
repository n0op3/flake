{ pkgs, settings, ... }:
{
  users.users.${settings.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "render"
      "audio"
      "input"
      "uinput"
      "libvirtd"
      "wireshark"
      "avahi"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
