{ pkgs, ... }:
# let
#   bambu-studio-wrapper = ''
#     export __GLX_VENDOR_LIBRARY_NAME=mesa
#     export __EGL_VENDOR_LIBRARY_FILENAMES=/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json
#     export MESA_LOADER_DRIVER_OVERRIDE=zink
#     export GALLIUM_DRIVER=zink
#     export WEBKIT_DISABLE_DMABUF_RENDERER=1
#   '';
#   orca-slicer-fixed = pkgs.writeShellScriptBin "orca-slicer" ''
#     ${bambu-studio-wrapper}
#     exec ${pkgs.orca-slicer}/bin/orca-slicer "$@"
#   '';
#   bambu-studio-fixed = pkgs.writeShellScriptBin "bambu-studio" ''
#     ${bambu-studio-wrapper}
#     exec ${pkgs.bambu-studio}/bin/bambu-studio "$@"
#   '';
# in
{
  home.packages = with pkgs; [
    kicad
    # orca-slicer-fixed
    # bambu-studio-fixed
  ];
}
