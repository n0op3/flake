{ inputs, system, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      # TODO: remove once nixpkgs adds libgpg-error to vial's extraPkgs
      vial = prev.callPackage ./pkgs/vial.nix { };

      # nixpkgs' sone (0.23.0) renders its blurred/animated UI surfaces every
      # frame; with WebKit's DMA-BUF path disabled (which sone itself does
      # when the NVIDIA module is loaded) that means single-digit FPS.
      # Use upstream master, which bakes those effects into cached canvases
      # and exposes Settings -> General -> Rendering (Auto/GPU/CPU).
      sone = (inputs.sone.packages.${system}.sone).overrideAttrs (old: {
        # Upstream's pnpmDeps hash was produced with a different pnpm version;
        # recompute it against the pnpm from our nixpkgs.
        pnpmDeps = final.fetchPnpmDeps {
          inherit (old) pname version src;
          pnpm = final.pnpm_11;
          fetcherVersion = 4;
          hash = "sha256-zaX+fsEWaNmgL2Ib3LG5+k2AYbJO/QexXnOtQeHaCDk=";
        };
      });
    })
  ];
}
