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
    git
    fzf
    ripgrep
    lsd
    zoxide
    bat
    tmux
    duf
    gdu
    yazi
    sleek-grub-theme
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "lavender";
    })
  ];
}
