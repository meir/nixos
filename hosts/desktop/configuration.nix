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
    (niri.override {
      config_file = ./config/niri/niri.kdl;
    })
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
    autostart = [
      "thunderbird"
      "discord"
      "sleep 5 && amberol"
    ];
  };

  fileSystems."/games" = {
    device = "/dev/disk/by-partuuid/be90f083-8588-4832-befa-72e81ce0a948";
    fsType = "ext4";
  };
}
