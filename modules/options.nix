{ lib, ... }: {
  options.nihonConfig = {
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gaming-related packages and settings";
    };
    music.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable music production packages and low-latency audio settings";
    };
    graphicsDesign.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable graphic design packages";
    };
    softwareDev.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable software development packages";
    };
    engineering.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable engineering packages";
    };
    cybersec.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable cybersecurity packages and settings";
    };
    plymouth.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable silent boot and plymouth";
    };
  };
}
