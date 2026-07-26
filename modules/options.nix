{ lib, ... }: {
  options.nihonConfig = {
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gaming-related packages and settings";
    };
  };
}
