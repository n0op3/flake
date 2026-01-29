{ pkgs, ... }: {
  users.users.n0op3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
