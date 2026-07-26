{ lib, ... }: {
  nix.settings = {
    cores = 10;
    max-jobs = "auto";

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "googleearth-pro-7.3.7.1155"
      "openssl-1.1.1w"
      "pnpm-10.29.2"
      "electron-40.10.5"
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    # Any missing dynamic libraries for unpackaged programs
    # go here, NOT in environment.systemPackages
  ];
}
