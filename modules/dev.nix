{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    git-credential-manager
    git-filter-repo
    clang
    clang-tools
    bear
    gdb
    cmake
    gnumake
    lua51Packages.lua
    luarocks
    just
    go
    jq
    opencode
    python3
    pkg-config
    glrnvim
    rustup
    cargo-binstall
    tokei
    silicon
    rpi-imager
    cloudflared
    syncthing
    github-cli
  ];

  services.syncthing.enable = true;
}
