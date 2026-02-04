{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    btop
    killall
    clang
    gnumake
    lua51Packages.lua
    lua
    luarocks
    cargo
    fzf
    ripgrep
    lsd
    zoxide
    bat
    tmux
    unzip
    duf
    gdu
    yazi
    trash-cli
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "lavender";
    })
  ];
}
