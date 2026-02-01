{ pkgs, ... }: {
  users.users.n0op3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" "libvirt" "wireshark" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  };
}
