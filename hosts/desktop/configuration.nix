{
  pkgs,
  modules,
  ...
}@inputs:
{
  # info
  user = "human";
  hostname = "desktop";

  # apps
  environment.systemPackages = with pkgs; [
    gimp
    (wrapOBS { plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ]; })
    (prismlauncher.override {
      additionalPrograms = [ vlc ];
      additionalLibs = [ vlc ];
    })
    spotify
    stremio
    thunderbird
    aseprite
    foliate
    miru
    amberol
    orca-slicer
    votv
    steam-vdf
  ];

  imports = with modules; useMods inputs [
    amdgpu
    bluetooth
    docker
    (eww.override {
      config_files = ./config/eww;
      widgets = [ "mon1" "mon2" ];
    })
    (rofi.override {
      config_files = ./config/rofi;
    })
    (mako.override {
      config_files = ./config/mako/config;
    })
    swww
    nautilus
    steam
    (monado.override {
      watch = ./config/wlxoverlay/watch.yaml;
      keyboard = ./config/wlxoverlay/keyboard.yaml;
    })
    discord
    mprisence
    zenbrowser
    neovim
    onepassword
    qmk
  ];

  # config

  protocol = {
    rules = [
      "monitor = HDMI-A-2, 2560x1080, 1920x0, 1"
      "monitor = DP-1, 1920x1080, 0x0, 1"
      "workspace = 1, monitor:HDMI-A-2, default:true"
      "workspace = 2, monitor:HDMI-A-2"
      "workspace = 3, monitor:HDMI-A-2"
      "workspace = 4, monitor:HDMI-A-2"
      "workspace = 5, monitor:HDMI-A-2"
      "workspace = 6, monitor:DP-2, default:true"
      "workspace = 7, monitor:DP-2"
      "workspace = 8, monitor:DP-2"
      "workspace = 9, monitor:DP-2"
      "workspace = 10, monitor:DP-2"

      "windowrulev2 = workspace 10, class:^(thunderbird)$"
      "windowrulev2 = workspace 6, class:^(discord)$"
      "windowrulev2 = workspace 7, class:^(Amberol)$"
      ''
        device {
          name=wacom-intuos-bt-s-pen
          output=HDMI-A-2
        }
      ''
    ];

    autostart = [
      "thunderbird"
      "discord"
      "amberol"
    ];
  };

  fileSystems."/games" = {
    device = "/dev/disk/by-partuuid/be90f083-8588-4832-befa-72e81ce0a948";
    fsType = "ext4";
  };
}
