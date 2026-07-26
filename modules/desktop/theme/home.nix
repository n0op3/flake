{ inputs, ... }: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = false;

    kvantum = {
      enable = true;
      apply = true;
      accent = "lavender";
      flavor = "mocha";
    };
  };
}
