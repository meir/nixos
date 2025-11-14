{
  pkgs,
  ...
}:
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
  ];

  modules = {
    amdgpu.enable = true;
    bluetooth.enable = true;
    containerization.enable = true;
    eww = {
      enable = true;
      widgets = [
        "mon1"
        "mon2"
      ];
    };
    rofi.enable = true;
    mako.enable = true;
    swww.enable = true;
    nautilus.enable = true;
    steam.enable = true;
    steamvr = {
      enable = true;
      runtime = "monado";
    };
    discord.enable = true;
    browser = "zenbrowser";
    nvim.enable = true;
    onepassword.enable = true;
    qmk.enable = true;
  };

  # config

  protocol = {
    rules = [
      "monitor = HDMI-A-2, 2560x1080, 1920x0, 1"
      "monitor = DP-2, 1920x1080, 0x0, 1"
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
      "windowrulev2 = workspace 7, class:^(Spotify)$"
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
      "spotify"
    ];
  };

  fileSystems."/games" = {
    device = "/dev/disk/by-partuuid/be90f083-8588-4832-befa-72e81ce0a948";
    fsType = "ext4";
  };
}
