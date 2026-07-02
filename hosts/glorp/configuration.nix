{
  pkgs,
  modules,
  config,
  ...
}@inputs:
let
  assets = import ../../config;
in
{
  # info
  user = "human";
  hostname = "glorp";

  # apps
  environment.systemPackages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ vlc ];
      additionalLibs = [ vlc ];
    })
    spotify
    thunderbird
    stremio-linux-shell
    btop
    teams-for-linux
  ];

  imports = with modules; useMods assets inputs [
    intel
    (niri.override {
      login_background = assets.sddm_nixos_waves;
    })
    bluetooth
    docker
    quickshell
    rofi
    mako
    awww
    nautilus
    steam
    discord
    mprisence
    (zenbrowser.override {
      profile = "ticptiit";
    })
    neovim
    onepassword
    rtl-sdr
  ];

  hardware.sensor.iio.enable = true;
  services.iio-niri = {
    enable = true;

    extraArgs = [
      "--monitor"
      "eDP-1"
    ];
  };

  # config
  niri = {
    displays = {
      "eDP-1" = {
        mode = "1920x1080";
        position = "x=0 y=0";
      };
    };
    autostart = [
      "thunderbird"
      "discord"
      "spotify"
    ];
  };
}
