{
  pkgs,
  unstable,
  config,
  lib,
  ...
}:
{
  imports = [ ./revolutions ];

  config = {
    user = "meir";

    environment.packages = with pkgs; [
      discord
      spotify
      stremio
      thunderbird
      scrot
      slack
      xlockmore
      blueman
      whatsapp-for-linux
    ];

    sxhkd.keybind = {
      "Print" = ''
        scrot -s -e 'xclip -selection clipboard -t image/png -i $f' &
      '';
    };

    bspwm.rules = [ "bspc monitor -d 1 2 3 4 5 6 7 8 9 10" ];

    modules = {
      docker.enable = true;
      dunst.enable = true;
      eww = {
        enable = true;
        widgets = [ "laptop" ];
      };
      feh.enable = true;
      nvim.enable = true;
      onepassword.enable = true;
      qmk.enable = true;
      qutebrowser.enable = true;
      rofi.enable = true;
      kitty.enable = true;
      zsh.enable = true;
      walld.enable = true;
    };

    boot.initrd.availableKernelModules = [
      "usb_storage"
      "sd_mod"
    ];
    boot.supportedFilesystems = [ "ntfs" ];

    hardware.bluetooth.enable = true;

    services.xserver = {
      videoDrivers = [ "intel" ];
    };

    services.xserver.dpi = 180;
    environment.variables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    };
  };
}
