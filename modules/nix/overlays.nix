{ inputs, ... }:
{
  nixpkgs.overlays = with inputs; [
    mac-style-plymouth.overlays.default
    millenium.overlays.default
    fenix.overlays.default
  ];
}
