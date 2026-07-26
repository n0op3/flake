{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options = {
    programs.waywall = {
      width = lib.mkOption {
        type = lib.types.int;
        default = 2560;
      };

      height = lib.mkOption {
        type = lib.types.int;
        default = 1440;
      };
    };
  };

  config = {
    programs.waywall = {
      enable = true;
      config = {
        enableWaywork = true;
        linkWithSystemd = false;

        source = ./waywall.lua;

        programs = [ mcsrPkgs.ninjabrain-bot ];
      };
    };
  };
}
