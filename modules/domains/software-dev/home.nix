{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ./gamedev.nix
    ./webdev.nix
  ];

  home.packages = with pkgs; [
    # Additional editors
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    glrnvim

    # Toolchains
    gcc
    cmake
    meson
    ninja
    gnumake
    lua51Packages.lua
    luarocks
    go
    python3
    android-tools

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
    wayland-scanner
    jq
    pkgs-unstable.opencode
    pkg-config
    tokei
    silicon
    rpi-imager
    cloudflared
    litecli
  ];

  services.syncthing.enable = true;

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
