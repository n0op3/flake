{
  inputs,
  lib,
  nihonConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf nihonConfig.graphicsDesign.enable {
    home.packages = with pkgs; [
      gimp
      inkscape
      fontforge-gtk
      krita
      figma-linux
      (pkgs.symlinkJoin {
        name = "blender";
        paths = [
          inputs.blender-bin.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/blender \
            --set __NV_PRIME_RENDER_OFFLOAD 1 \
            --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia \
            --set __VK_LAYER_NV_optimus NVIDIA_only
        '';
      })
    ];
  };
}
