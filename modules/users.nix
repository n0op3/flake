{ pkgs, ... }: {
  users.users.n0op3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" "libvirt" "wireshark" ];
    shell = pkgs.zsh;
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  };
}
