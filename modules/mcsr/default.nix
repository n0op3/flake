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

  home.packages = [
    mcsrPkgs.ninjabrain-bot
  ];
}
