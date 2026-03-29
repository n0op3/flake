{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    git-credential-manager
    git-filter-repo
    just
    go
    gcc
    bear
    opencode
    python3
    pkg-config
    glrnvim
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    tokei
  ];
}
