{
  lib,
  nihonConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf nihonConfig.engineering.enable {
    home.packages = with pkgs; [
      kicad
      arduino-cli
    ];
  };
}
