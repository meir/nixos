{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  environment.defaultPackages = with pkgs; [ xorg.xf86videonouveau ];

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

    displayManager = {
      lightdm = {
        enable = true;
      };
    };
  };

  services.displayManager.defaultSession = "none+bspwm";

  services.picom = {
    enable = true;

    vSync = true;

    settings = {
      blur = {
        method = "gaussian";
        size = 5;
        deviation = 5.0;
      };
    };
  };
}
