{
  pkgs,
  modules,
  config,
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
    thunderbird
    aseprite
    foliate
    amberol
    orca-slicer
    votv
    steam-vdf
    unstable.vintagestory
    lutris
    kicad
    blockbench
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
      config_file = ./config/wlxoverlay/config.yaml;
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
      "spotify"
    ];
  };
}
