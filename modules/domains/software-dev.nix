{ inputs, pkgs, ... }:
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
    android-tools

    # Rust
    rustup
    bacon
    cargo-xwin
    cargo-audit
    cargo-nextest
    cargo-binstall
    cargo-tarpaulin

    # Utilities
    git-credential-manager
    git-filter-repo
    github-cli
    bear
    gdb
    inputs.pwndbg.packages.${pkgs.stdenv.hostPlatform.system}.pwndbg
    just
    perf
    hotspot
    jq
    opencode
    pkg-config
    tokei
    silicon
    rpi-imager
    cloudflared
    syncthing
    litecli
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
