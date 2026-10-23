{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.musnix.nixosModules.musnix ];

  config = lib.mkMerge [
    {
      services.pipewire = {
        alsa.enable = true;
        pulse.enable = true;
      };
    }
    (lib.mkIf config.nihonConfig.music.enable {
      musnix.enable = true;
      services.pipewire = {
        alsa.support32Bit = true;
        jack.enable = true;
      };
    })
  ];
}
