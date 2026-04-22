{ pkgs, ... }:
{
  musnix.enable = true;

  services.pipewire.alsa = {
    enable = true;
    support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    lmms
    vital
    yabridge
    yabridgectl
    audacity
    (carla.override {
      withQt = true;
    })
  ];
}
