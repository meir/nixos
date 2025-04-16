{
  pkgs,
  ...
}:
{
  user = "human";

  environment.systemPackages = with pkgs; [
    gimp
    (wrapOBS { plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ]; })
    prismlauncher
    spotify
    stremio
    thunderbird
    retroarch
    unityhub
    aseprite
    foliate
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
      "windowrulev2 = workspace 7, class:^(Spotify)$"
    ];

    autostart = [
      "thunderbird"
      "discord"
      "spotify"
    ];
  };

  modules = {
    amdgpu.enable = true;
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
    steam.enable = true;
    steamvr = {
      enable = true;
      runtime = "steamvr";
    };
    discord.enable = true;
    qutebrowser.enable = true;
    nvim.enable = true;
    onepassword.enable = true;
    qmk.enable = true;
  };

  hardware.bluetooth.enable = true;

  fileSystems."/games" = {
    device = "/dev/disk/by-partuuid/be90f083-8588-4832-befa-72e81ce0a948";
    fsType = "ext4";
  };

  fileSystems."/windows" = {
    device = "/dev/disk/by-partuuid/2d5a610a-d995-4cf3-8153-34e0a9d66cf5";
    fsType = "ntfs";
  };
}
