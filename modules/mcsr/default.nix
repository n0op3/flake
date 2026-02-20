{
  osConfig,
  ...
}:
{
  xdg.configFile."waywall/init.lua".source = osConfig.programs.waywall.config.finalFile;
}
