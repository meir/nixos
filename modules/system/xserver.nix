{ config, options, pkgs, lib, ... }:
with lib; {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.xterm.enable = true;

    displayManager = {
      defaultSession = "none+bspwm";
      lightdm = { enable = true; };
    };
  };

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
