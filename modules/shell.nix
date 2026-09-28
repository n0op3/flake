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
    "nsp" = "nom-shell -p --command zsh";
    "dv" = "nom develop -c $SHELL";
    "dvi" = "nom develop --impure -c $SHELL";
    "rm" = "trash";
    "del" = "/run/current-system/sw/bin/rm";
    "bandwhich" = "sudo bandwhich";
  };
}
