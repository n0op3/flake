{
  lib,
  config,
  pkgs,
  mcsr-nixos,
  ...
}:
let
  mcsrPkgs = mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ mcsr-nixos.nixosModules.waywall ];

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

        text = ''
          local resolution = { w = ${toString config.programs.waywall.width}, h = ${toString config.programs.waywall.height} }
        '';

        programs = [ mcsrPkgs.ninjabrain-bot ];
      };
    };
  };

}
