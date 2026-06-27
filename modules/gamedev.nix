{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unityhub
    roslyn-ls
    dotnet-sdk_10
  ];
}
