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
    unigine-superposition
    rocmPackages.rocm-smi
  ];

  protocol = {
    type = "xorg";

    # rules = [
    #   "monitor = HDMI-A-2, 2560x1080, 0x0, 1"
    #   "monitor = DP-1, 1920x1080, -2560x0, 1"
    # ];

    hotkeys = [
      ''
        Print
          hyprland | exec, ${lib.getExe pkgs.flameshot} gui
          ${lib.getExe pkgs.flameshot} gui
      ''
      # close, kill app
      ''
        super + {_,shift + }q
          sxhkd | bspc node -{c,k}
          hyprland | {closewindow,killactive}
      ''

      # change mode
      ''
        super + {t,shift + t,s,f}
          sxhkd | bspc node -t {tiled,pseudo_tiled,floating,fullscreen}
          hyprland | {settiled,pseudo,setfloating,fullscreen}
      ''

      # resize window
      ''
        super + mouse_lmb | hyprland[m]
          hyprland | movewindow

        super + mouse_rmb | hyprland[m]
          hyprland | resizewindow
      ''

      # set flag
      ''
        super + shift + {m,x,y,z}
          sxhkd | bspc node -g {marked,locked,sticky,private}
      ''

      # focus/move the node in given direction
      ''
        super + {_,shift + }{h,j,k,l}
          sxhkd | bspc node -{f,s} {west,south,north,east}
          hyprland | movefocus, {l,d,u,r}
      ''

      # move (node) to desktop
      ''
        super + {_,shift + }{1,2,3,4,5,6,7,8,9,0}
          sxhkd | bspc {desktop -f,node -d} '^{1,2,3,4,5,6,7,8,9,10}'
          hyprland | movetoworkspace, {1,2,3,4,5,6,7,8,9,10}
      ''

      # reload sxhkd config
      ''
        shift + super + r
          sxhkd | pkill -x sxhkd && sxhkd &
          hyprland | exec, hyprctl reload
      ''
    ];

    autostart = [ "discord &" ];

    rules = [
      "bspc wm -O HDMI-A-1 DisplayPort-0"
      "bspc monitor HDMI-A-1 -d 1 2 3 4 5"
      "bspc monitor DisplayPort-0 -d 6 7 8 9 10"

      "bspc rule -a retroarch state=floating"
      "bspc rule -a 'discord' desktop='^6'"
    ];
  };

  services.xserver = {
    xrandrHeads = [
      "DisplayPort-0"
      {
        output = "HDMI-A-1";
        primary = true;
      }
    ];
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
    lact.enable = true;
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
