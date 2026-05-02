{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "sunshine-wrapped";
      paths = [ sunshine ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/sunshine \
          --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib
      '';
    })
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  hardware.graphics.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  systemd.user.services.sunshine.environment = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver/lib64";
  };
}
