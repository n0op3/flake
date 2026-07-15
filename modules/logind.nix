{
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandlePowerKey = "suspend";
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      clear_password = true;
    };
  };
}
