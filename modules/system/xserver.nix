{ config, options, pkgs, lib, ... }:
with lib; {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.xterm.enable = true;

    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    displayManager = { lightdm = { enable = true; }; };
  };

  services.displayManager.defaultSession = "none+bspwm";

  services.picom = {
    enable = true;

    vSync = true;

    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
    };
  };

  environment.file = {
    bspwm = {
      source = ./assets/bspwm/bspwmrc;
      target = ".config/bspwm/bspwmrc";
    };
    sxhkd = {
      source = ./assets/sxhkd/sxhkdrc;
      target = ".config/sxhkd/sxhkdrc";
    };
  };
}
