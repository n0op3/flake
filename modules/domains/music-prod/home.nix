{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lmms-full
    vital
    yabridge
    yabridgectl
    sfizz-ui
    audacity
    qpwgraph
    pipewire.jack
    calf
    noise-repellent
    lsp-plugins
    x42-plugins
    (carla.override {
      withQt = true;
    })
  ];
}
