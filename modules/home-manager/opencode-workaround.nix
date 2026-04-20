{ config, lib, ... }:

{
  options.programs.opencode.tui = lib.mkOption {
    type = lib.types.anything;
    default = { };
    description = "OpenCode TUI configuration (workaround for catppuccin)";
  };
}