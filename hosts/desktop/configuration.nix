{
  pkgs,
  config,
  lib,
  ...
}:
{
  user = "human";

  theme.evergreen.enable = true;

  environment.systemPackages = with pkgs; [
    gimp
    prismlauncher
    spotify
    stremio
    thunderbird
    retroarch
    unityhub
    aseprite
    zathura
  ];

  protocol = {
    type = "wayland";

    rules = [
      "monitor = HDMI-A-2, 2560x1080, 1920x0, 1"
      "monitor = DP-1, 1920x1080, 0x0, 1"
      "workspace = 1, monitor:HDMI-A-2, default:true"
      "workspace = 2, monitor:HDMI-A-2"
      "workspace = 3, monitor:HDMI-A-2"
      "workspace = 4, monitor:HDMI-A-2"
      "workspace = 5, monitor:HDMI-A-2"
      "workspace = 6, monitor:DP-1, default:true"
      "workspace = 7, monitor:DP-1"
      "workspace = 8, monitor:DP-1"
      "workspace = 9, monitor:DP-1"
      "workspace = 10, monitor:DP-1"

      "windowrulev2 = workspace 10, class:^(thunderbird)$"
      "windowrulev2 = workspace 6, class:^(discord)$"
    ];

    autostart = [
      "thunderbird"
      "discord"
    ];
  };

  services.xserver = {
    xrandrHeads = [
      "DP-1"
      {
        output = "HDMI-A-2";
        primary = true;
      }
    ];
  };

  modules = {
    containerization.enable = true;
    discord.enable = true;
    eww.enable = true;
    eww.widgets = [
      "mon1"
      "mon2"
    ];
    mpv.enable = true;
    nvim.enable = true;
    obs.enable = true;
    onepassword.enable = true;
    qmk.enable = true;
    qutebrowser.enable = true;
    rofi.enable = true;
    steam.enable = true;
    steamvr.enable = true;
  };

  # additional hardware configuration
  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  powerManagement.enable = false;
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
      configurationLimit = 50;
    };
    efi.canTouchEfiVariables = true;
  };
}
