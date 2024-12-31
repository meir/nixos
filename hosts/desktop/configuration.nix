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
  ];

  protocol = {
    type = "wayland";

    rules = [
      "monitor = HDMI-A-2, 2560x1080, 0x0, 1"
      "monitor = DP-1, 1920x1080, -1920x0, 1"
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
    ];

    hotkeys = [
      ''
        Print
          hyprland | exec, ${lib.getExe pkgs.flameshot} gui
          ${lib.getExe pkgs.flameshot} gui
      ''
      # close app
      ''
        super + q
          sxhkd | bspc node -c
          hyprland | killactive
      ''
      # kill app
      ''
        super + shift + q
          sxhkd | bspc node -k
          hyprland | exec, hyprctl activewindow -j | jq -r '.pid' | xargs kill
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
          sxhkd | bspc {desktop -f,node -d} {1,2,3,4,5,6,7,8,9,10}
          hyprland | {workspace,movetoworkspace}, {1,2,3,4,5,6,7,8,9,10}
      ''

      # reload sxhkd config
      ''
        shift + super + r
          sxhkd | pkill -x sxhkd && sxhkd &
          hyprland | exec, hyprctl reload
      ''
    ];

    autostart = [
      "discord &"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "swww init"
    ];

    # rules = [
    #   "bspc wm -O DisplayPort-0 HDMI-A-1"
    #   "bspc monitor HDMI-A-1 -d 1 2 3 4 5"
    #   "bspc monitor DisplayPort-0 -d 6 7 8 9 10"
    #
    #   "bspc rule -a retroarch state=floating"
    #   "bspc rule -a 'discord' desktop='^6'"
    # ];
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
