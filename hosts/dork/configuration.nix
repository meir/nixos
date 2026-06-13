{
  pkgs,
  modules,
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
      config_file = ../../config/niri/niri.kdl;
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
      config_files = ../../config/rofi/config.rasi;
    })
    mako
    awww
    nautilus
    steam
    modding
    (monado.override {
      wayvr_config = ../../config/wayvr;
    })
    discord
    spotify
    mprisence
    (zenbrowser.override {
      profile = "6nnl61tq";
    })
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
    displays = {
      "HDMI-A-2" = {
        id = 0;
        mode = "2560x1080";
        position = "x=0 y=0";
      };
      "DP-1" = {
        id = 1;
        mode = "1920x1080";
        position = "x=-1920 y=0";
      };
    };
    autostart = [
      "thunderbird"
      "discord"
      "spotify"
      "easyeffects --hide-window"
    ];
  };
}
