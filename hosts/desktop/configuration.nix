{
  pkgs,
  config,
  lib,
  ...
}:
{
  user = "human";

  theme.evergreen = {
    enable = true;
    font_size = 12;
  };

  environment.systemPackages = with pkgs; [
    discord
    gimp
    libsForQt5.kdenlive
    lmms
    prismlauncher
    unstable.r2modman
    spotify
    stremio
    olive-editor
    thunderbird
    retroarch
    unstable.manga-tui
    unityhub
  ];

  protocol = {
    type = "xorg";

    hotkeys = [
      ''
        Print
          ${lib.getExe pkgs.flameshot} gui
      ''
    ];

    autostart = [ "discord &" ];

    rules = [
      "bspc wm -O HDMI-0 DP-2"
      "bspc monitor HDMI-0 -d 1 2 3 4 5"
      "bspc monitor DP-2 -d 6 7 8 9 10"

      "bspc rule -a retroarch state=floating"
      "bspc rule -a 'discord' desktop='^6'"
    ];
  };

  services.xserver = {
    xrandrHeads = [
      "DP-2"
      {
        output = "HDMI-0";
        primary = true;
      }
    ];
    displayManager.setupCommands = ''
      ${lib.getExe pkgs.xorg.xrandr} --output HDMI-0 --right-of DP-2
    '';
  };

  programs = {
    noisetorch.enable = true;
  };

  modules = {
    docker.enable = true;
    droidcam.enable = true;
    dunst.enable = true;
    eww.enable = true;
    eww.widgets = [
      "mon1"
      "mon2"
    ];
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
    vm.enable = true;
    vm.pciIds = [
      "10de:2482"
      "10de:228b"
    ];
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

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
      configurationLimit = 50;
    };
    efi.canTouchEfiVariables = true;
  };
}
