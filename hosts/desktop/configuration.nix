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
    rocket-league
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
    (steam.override {
      apps = {
        VRChat = {
          id = 438100;
          compatTool = "GE-Proton10-24";
          launchOptions = "env PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc %command% -screen-width 100 -screen-height 60";
        };
      };
    })
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
      "spotify"
    ];
  };
}
