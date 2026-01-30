{ pkgs, ... }: {
  users.users.n0op3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" "libvirt" "wireshark" ];
    shell = pkgs.zsh;
  };
}
