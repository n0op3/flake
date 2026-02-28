{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services.pipewire.alsa = {
    enable = true;
    support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    lmms
    yabridge
    yabridgectl
    (carla.override {
      withQt = true;
    })
  ];
}
