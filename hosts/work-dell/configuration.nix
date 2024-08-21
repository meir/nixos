{
  pkgs,
  unstable,
  config,
  lib,
  ...
}:
{
  user = "meir";

  theme.evergreen = {
    enable = true;
    font_size = 22;
    dpi = 2;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024; # 16GB
    }
  ];

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
    teams-for-linux
    dig
    anthy
    globalprotect-openconnect
    nodePackages.asar
  ];

  services = {
    globalprotect.enable = true;

    xserver = {
      videoDrivers = [ "intel" ];
      autorun = true;

      xautolock = {
        enable = true;
        time = 10;
      };
    };

    libinput.mouse.accelProfile = "flat";
  };

  protocol = {
    type = "xorg";

    hotkeys = {
      "Print" = ''
        scrot -s -e 'xclip -selection clipboard -t image/png -i $f' &
      '';
      "super + shift + l" = ''
        xlock
      '';
    };

    autostart = [
      "discord &"
      "slack &"
      "whatsapp-for-linux &"
      "thunderbird &"
      "gpclient --now &"
    ];

    rules = [ ];
  };

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
    mpv.enable = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  boot = {
    initrd = {
      availableKernelModules = [
        "usb_storage"
        "sd_mod"
      ];
    };

    supportedFilesystems = [ "ntfs" ];
  };

  hardware.bluetooth.enable = true;
}
