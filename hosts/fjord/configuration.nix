{ pkgs, config, ... }:
{
  config = {
    user = "human";

    environment.packages = with pkgs; [
      gimp
      prismlauncher
      spotify
      stremio
      wirelesstools
    ];

    modules = {
      discord.enable = true;
      docker.enable = true;
      dunst.enable = true;
      eww.enable = true;
      feh.enable = true;
      nvim.enable = true;
      onepassword.enable = true;
      polybar.enable = true;
      qutebrowser.enable = true;
      rofi.enable = true;
      steam.enable = true;
      kitty.enable = true;
      zsh.enable = true;
    };

    # set txpower to 10dBm
    systemd.user.services.txpower = {
      enable = true;
      path = [ pkgs.wirelesstools ];
      unitConfig = {
        PartOf = [ "graphical-session.target" ];
      };
      wantedBy = [ "graphical-session.target" ];
      description = "wlp2s0 txpower";
      serviceConfig = {
        Type = "forking";
        ExecStart = ''
          ${pkgs.wirelesstools}/bin/iwconfig wlp2s0 txpower 10
        '';
        Restart = "on-failure";
      };
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

    bspwm.rules = [ "bspc monitor -d 1 2 3 4 5 6 7 8 9 10" ];
  };
}
