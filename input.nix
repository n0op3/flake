{ pkgs, ... }: {
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  hardware.opentabletdriver.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      laptop = {
        ids = [ "048d:c100:5d4326cd" ];
        settings = {
          main = {
            capslock = "overload(meta, esc)";
            esc = "capslock";
          };
          alt = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            a = "volumeup";
            z = "volumedown";
            x = "mute";
          };
        };
      };
    };
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
}
