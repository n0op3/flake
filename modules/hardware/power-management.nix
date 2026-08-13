{ pkgs, ... }: {
  powerManagement = {
    enable = true;
  };

  systemd.services.set-platform-profile = {
    description = "Set ACPI platform profile to quiet on boot";
    wantedBy = [ "multi-user.target" ];
    after = [
      "tlp.service"
      "multi-user.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo low-power > /sys/firmware/acpi/platform_profile'";
    };
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  # NOTE: allow executing gamemoderun commands without sudo prompt
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.policykit.exec" &&
          subject.isInGroup("wheel")) {
        var program = action.lookupString("program");
        if (program && (program.match(/cpugovctl$/) || program.match(/procsysctl$/))) {
          return polkit.Result.YES;
        }
      }
    });
  '';
}
