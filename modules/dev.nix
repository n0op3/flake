{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    git-credential-manager
    git-filter-repo
    clang
    cmake
    gnumake
    lua51Packages.lua
    luarocks
    just
    go
    bear
    opencode
    python3
    pkg-config
    glrnvim
    rustup
    cargo-binstall
    tokei
  ];
}
