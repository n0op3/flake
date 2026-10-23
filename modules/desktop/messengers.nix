{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop
    vesktop
    element-desktop
    inputs.concord.packages.${pkgs.stdenv.hostPlatform.system}.concord
  ];
}
