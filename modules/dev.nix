{ pkgs, ... }:
{
  imports = [
    ./webdev.nix
  ];

  home.packages = with pkgs; [
    # Additional editors
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    glrnvim

    # Toolchains
    clang
    clang-tools
    cmake
    gnumake
    lua51Packages.lua
    luarocks
    go
    python3
    rustup
    cargo-binstall

    # Utilities
    git-credential-manager
    git-filter-repo
    github-cli
    bear
    gdb
    just
    jq
    opencode
    pkg-config
    tokei
    silicon
    rpi-imager
    cloudflared
    syncthing
  ];

  programs.jujutsu.enable = true;
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;

      credential = {
        helper = "store";
        credentialStore = "gpg";
      };

      user = {
        name = "n0op3";
        email = "n0op3@proton.me";
      };
    };
  };
}
