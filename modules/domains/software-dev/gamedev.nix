{
  lib,
  nihonConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf nihonConfig.softwareDev.enable {
    home.packages = with pkgs; [
      unityhub
      godot
      roslyn-ls
      dotnet-sdk_10
    ];
  };
}
