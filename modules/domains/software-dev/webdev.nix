{
  lib,
  nihonConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf nihonConfig.softwareDev.enable {
    home.packages = with pkgs; [
      nodejs
    ];
  };
}
