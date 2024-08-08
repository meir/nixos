{
  pkgs,
  unstable,
  config,
  lib,
  ...
}:
{
  user = "meir";

  themes.evergreen = {
    enable = true;
  };

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

    ruby
    nodejs
    php81Packages.composer

    globalprotect-openconnect
    nodePackages.gulp
  ];

  environment.variables = {
    GEM_HOME = "$HOME/.ruby";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services = {
    globalprotect.enable = true;

    xserver = {
      videoDrivers = [ "intel" ];

      autorun = true;
      # 1016 x 635 divided by 1.8 to make up for dpi
      monitorSection = ''
        DisplaySize 564 352
      '';

      xautolock = {
        enable = true;
        time = 10;
      };
    };
  };

  sxhkd.keybind = {
    "Print" = ''
      scrot -s -e 'xclip -selection clipboard -t image/png -i $f' &
    '';
    "super + shift + l" = ''
      xlock
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

  powerManagement.cpuFreqGovernor = "powersave";

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
