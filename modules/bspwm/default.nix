{ config, options, pkgs, lib, ... }:
with lib; {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    windowManager.bspwm = {
      enable = true;
      configFile = "${config.user_home}/.config/bspwm/bspwmrc";
      sxhkd.configFile = "${config.user_home}/.config/sxhkd/sxhkdrc";
    };

    desktopManager.xterm.enable = true;

    displayManager = {
      defaultSession = "none+bspwm";
      lightdm = { enable = true; };
    };
  };

  services.picom = {
    enable = true;

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
      source = ./bspwmrc;
      target = ".config/bspwm/bspwmrc";
    };
    sxhkd = {
      source = ./sxhkdrc;
      target = ".config/sxhkd/sxhkdrc";
    };
  };
}
