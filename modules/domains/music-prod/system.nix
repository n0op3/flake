{ inputs, ... }: {
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
}
