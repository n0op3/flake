{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unityhub
    godot
    roslyn-ls
    dotnet-sdk_10
  ];
}
