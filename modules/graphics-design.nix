{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp
    inkscape
    fontforge-gtk
    krita
  ];
}
