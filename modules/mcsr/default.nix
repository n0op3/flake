{
  osConfig,
  pkgs,
  mcsr-nixos,
  ...
}:
let
  mcsrPkgs = mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  xdg.configFile."waywall/init.lua".source = osConfig.programs.waywall.config.finalFile;
  xdg.configFile."waywall/measuring_overlay.png".source = ./resources/measuring_overlay.png;

  home.packages = [
    mcsrPkgs.ninjabrain-bot
  ];
}
