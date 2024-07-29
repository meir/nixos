{
  pkgs,
  unstable,
  config,
  lib,
  ...
}:
{
  imports = [ ../../themes/revolutions ];

  config = {
    user = "human";

    environment.packages = with pkgs; [
      discord
      gimp
      libsForQt5.kdenlive
      lmms
      prismlauncher
      r2modman
      spotify
      stremio
      olive-editor
      thunderbird
      scrot
      retroarch
    ];

    sxhkd.keybind = {
      "Print" = ''
        scrot -s -e 'xclip -selection clipboard -t image/png -i $f' &
      '';
    };

    bspwm.rules = [
      "bspc wm -O HDMI-0 DP-0"
      "bspc monitor HDMI-0 -d 1 2 3 4 5"
      "bspc monitor DP-0 -d 6 7 8 9 10"
    ];

    services.xserver = {
      xrandrHeads = [
        "HDMI-0"
        "DP-0"
      ];

      displayManager.setupCommands = ''
        ${lib.getExe pkgs.xorg.xrandr} --output HDMI-0 --right-of DP-0
      '';
    };

    programs = {
      noisetorch.enable = true;
    };

    modules = {
      docker.enable = true;
      droidcam.enable = true;
      dunst.enable = true;
      eww = {
        enable = true;
        widgets = [
          "mon1"
          "mon2"
        ];
      };
      feh.enable = true;
      nvim.enable = true;
      obs.enable = true;
      onepassword.enable = true;
      qmk.enable = true;
      qutebrowser.enable = true;
      rofi.enable = true;
      steam.enable = true;
      steamvr.enable = true;
      kitty.enable = true;
      zsh.enable = true;
      nexusmods.enable = true;
      walld.enable = true;
    };

    # additional hardware configuration
    boot.initrd.availableKernelModules = [
      "usb_storage"
      "sd_mod"
    ];
    boot.supportedFilesystems = [ "ntfs" ];

    powerManagement.enable = false;
    hardware.bluetooth.enable = true;

    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
    };
  };
}
