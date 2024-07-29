{
  pkgs,
  unstable,
  config,
  ...
}:
{
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

      "bspc config normal_border_color '#131711'"
      "bspc config active_border_color '#10A070'"
      "bspc config focused_border_color '#D1496B'"
    ];

    services.xserver.xrandrHeads = [
      "HDMI-0"
      "DP-0"
    ];

    programs = {
      noisetorch.enable = true;
    };

    modules = {
      docker.enable = true;
      droidcam.enable = true;
      dunst = {
        enable = true;
        source = ../../themes/revolutions/dunst;
      };
      eww = {
        enable = true;
        source = ../../themes/revolutions/eww;
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
      rofi = {
        enable = true;
        source = ../../themes/revolutions/rofi;
      };
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
