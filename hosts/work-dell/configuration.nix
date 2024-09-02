{ pkgs, ... }:
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

  environment.systemPackages = with pkgs; [
    discord
    spotify
    stremio
    thunderbird
    flameshot
    slack
    xlockmore
    blueman
    whatsapp-for-linux
    teams-for-linux
    dig
    anthy
    globalprotect-openconnect
    unstable.manga-tui
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
        flameshot gui
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

    rules = [
      "bspc monitor -d 1 2 3 4 5 6 7 8 9 10"
      "bspc rule -a 'discord' desktop='^8'"
      "bspc rule -a 'Whatsapp-for-linux' desktop='^8'"
      "bspc rule -a 'thunderbird' desktop='^9'"
      "bspc rule -a 'Slack' desktop='^10'"
    ];
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
    timer.enable = true;
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
