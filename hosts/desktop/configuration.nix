{ pkgs, config, ... }:
{
  config = {
    user = "human";

    environment.packages = with pkgs; [
      gimp
      libsForQt5.kdenlive
      lmms
      prismlauncher
      r2modman
      spotify
      stremio
      gnome.nautilus
    ];

    programs.noisetorch.enable = true;

    modules = {
      discord.enable = true;
      docker.enable = true;
      dunst.enable = true;
      eww.enable = true;
      feh.enable = true;
      nvim.enable = true;
      obs.enable = true;
      onepassword.enable = true;
      polybar.enable = true;
      qmk.enable = true;
      qutebrowser.enable = true;
      rofi.enable = true;
      steam.enable = true;
      steamvr.enable = true;
      kitty.enable = true;
      zsh.enable = true;
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

    bspwm.rules = [
      "bspc wm -O HDMI-1 DP-2"
      "bspc monitor HDMI-1 -d 1 2 3 4 5"
      "bspc monitor DP-2 -d 6 7 8 9 10"
    ];
  };
}
