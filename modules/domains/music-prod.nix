{ inputs, pkgs, ... }:
{
  imports = [ inputs.musnix.nixosModules.musnix ];

  musnix.enable = true;

  services.pipewire = {
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lmms-full
    vital
    yabridge
    yabridgectl
    sfizz
    sfizz-ui
    audacity
    qpwgraph
    pipewire.jack
    calf
    easyeffects
    noise-repellent
    lsp-plugins
    eq10q
    x42-plugins
    (carla.override {
      withQt = true;
    })
  ];
}
