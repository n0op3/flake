{
  pkgs,
  inputs,
  ...
}:

let
  bambu-studio-wrapper = ''
    export __GLX_VENDOR_LIBRARY_NAME=mesa
    export __EGL_VENDOR_LIBRARY_FILENAMES=/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json
    export MESA_LOADER_DRIVER_OVERRIDE=zink
    export GALLIUM_DRIVER=zink
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
  '';
  orca-slicer-fixed = pkgs.writeShellScriptBin "orca-slicer" ''
    ${bambu-studio-wrapper}
    exec ${pkgs.orca-slicer}/bin/orca-slicer "$@"
  '';
  bambu-studio-fixed = pkgs.writeShellScriptBin "bambu-studio" ''
    ${bambu-studio-wrapper}
    exec ${pkgs.bambu-studio}/bin/bambu-studio "$@"
  '';
in
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    orca-slicer-fixed
    bambu-studio-fixed
    inputs.nixpkgs-anki-patch.legacyPackages.${pkgs.stdenv.hostPlatform.system}.anki
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
    blueberry
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

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
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

  services.kdeconnect.enable = true;

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
