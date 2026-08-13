{ inputs, pkgs, ... }:
{
  imports = [ inputs.musnix.nixosModules.musnix ];

  musnix.enable = true;

  services.pipewire.alsa = {
    enable = true;
    support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    lmms-full
    vital
    yabridge
    yabridgectl
    sfizz
    sfizz-ui
    audacity
    (carla.override {
      withQt = true;
    })
  ];
}
