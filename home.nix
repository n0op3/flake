{
  pkgs,
  inputs,
  ...
}:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    inputs.nixpkgs-anki-patch.legacyPackages.${pkgs.stdenv.hostPlatform.system}.anki
    unityhub
    roslyn-ls
    dotnetCorePackages.dotnet_9.sdk
    gnome-clocks
    vscode
    libreoffice
    fastfetch
    git-credential-manager
    vial
    qmk
    qmk-udev-rules
    mpv
    vesktop
    discord-canary
    stow
    starship
    kitty
    pywal16
    bibata-cursors
    papirus-icon-theme
    pywalfox-native
    tidal-hifi
    cava
    grimblast
    satty
    eog
    inputs.nixpkgs-wine10.legacyPackages.${pkgs.stdenv.hostPlatform.system}.wineWow64Packages.stableFull
    libnotify
    davinci-resolve
    networkmanager_dmenu
    dragon-drop
    ffmpeg
    gimp
    inkscape
    signal-desktop
    yt-dlp
    fd
    just
    go
    gcc
    bear
    opencode
    thunar
    russ
    pamixer
    python3
    pkg-config
    glrnvim
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    git-filter-repo
    tokei
    qalculate-gtk
    nwg-look
    vscode-extensions.vadimcn.vscode-lldb
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  gtk = rec {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    gtk4.theme = theme;
  };

  catppuccin.kvantum = {
    enable = true;
    apply = true;
    accent = "lavender";
    flavor = "mocha";
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kvantum";
  };

  programs.rofi = {
    enable = true;
    plugins = [ pkgs.rofi-emoji ];
    configPath = "";
  };

  services.kdeconnect.enable = false;

  home.file.".local/share/icons/default" = {
    source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice/";
    recursive = true;
  };

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
