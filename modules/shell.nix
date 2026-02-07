{ ... }:
{
  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.shellAliases = {
    "nrs" = "sudo nixos-rebuild switch";
    "nrsu" = "sudo nixos-rebuild switch --upgrade";
    "nsp" = "nix-shell -p --command zsh";
    "s" = "nix search nixpkgs";
    "rm" = "trash";
    "del" = "/run/current-system/sw/bin/rm";
    "dv" = "nix develop";
  };
}
