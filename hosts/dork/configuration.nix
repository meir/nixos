{
  pkgs,
  modules,
  config,
  ...
}@inputs:
{
  # info
  user = "human";
  hostname = "dork";

  # apps
  environment.systemPackages = with pkgs; [
    gimp
    (prismlauncher.override {
      additionalPrograms = [ vlc ];
      additionalLibs = [ vlc ];
    })
    spotify
    thunderbird
    aseprite
    orca-slicer
    stremio-linux-shell
    amberol
    bs-manager
    votv
    davinci-resolve
  ];

  imports = with modules; useMods inputs [
    (niri.override {
      config_file = ./config/niri/niri.kdl;
    })
    amdgpu
    obs
    bluetooth
    docker
    # (eww.override {
    #   config_files = ../../config/eww;
    #   widgets = [ "mon1" "mon2" ];
    # })
    (rofi.override {
      config_files = ../../config/rofi;
    })
    (mako.override {
      config_files = ../../config/mako/config;
    })
    awww
    nautilus
    steam
    modding
    (monado.override {
      watch = ../../config/wlxoverlay/watch.yaml;
      keyboard = ../../config/wlxoverlay/keyboard.yaml;
      config_file = ../../config/wlxoverlay/config.yaml;
    })
    discord
    mprisence
    zenbrowser
    neovim
    onepassword
    qmk
    rtl-sdr
    (quickshell.override {
      cwal_config = ../../config/cwal/cwal.ini;
      cwal_templates = ../../config/cwal/templates;
      quickshell_config = ../../config/quickshell;
    })
  ];

  # config
  niri = {
    autostart = [
      "thunderbird"
      "discord"
      "spotify"
      "easyeffects --hide-window"
    ];
  };
}
