{ inputs, ... }:
{
  imports = [ ./fixes.nix ];

  nixpkgs.overlays = with inputs; [
    mac-style-plymouth.overlays.default
    millenium.overlays.default
  ];
}
