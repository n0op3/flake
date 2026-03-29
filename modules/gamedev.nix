{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unityhub
    roslyn-ls
    dotnetCorePackages.dotnet_9.sdk
  ];
}
