{
  pkgs,
  modules,
  ...
}@inputs:
let
  assets = import ../../config;
in
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
    bs-manager
    votv
    davinci-resolve
  ];

  imports = with modules; useMods assets inputs [
    niri
    amdgpu
    obs
    bluetooth
    docker
    rofi
    mako
    awww
    nautilus
    steam
    modding
    (monado.override {
      vr_headset_sink = "AB13X";
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
    quickshell
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
