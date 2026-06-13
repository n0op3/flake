{
  pkgs,
  inputs,
  ...
}:
{
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandlePowerKey = "suspend";
  };

  services.displayManager.sddm = with pkgs.kdePackages; {
    enable = true;
    theme = "pixie";
    wayland.enable = true;

    package = sddm;

    extraPackages = [
      qtsvg
      qtdeclarative
      qt5compat
    ];
  };

  environment.systemPackages = [
    (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
      background = ../assets/sddm-bg.jpg;
      avatar = ../assets/avatar.png;
      autoColor = true;
      fontFamily = "JetBrains Mono";
      fontSize = 13;
    })
  ];

}
