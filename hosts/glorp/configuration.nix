{
  pkgs,
  modules,
  config,
  ...
}@inputs:
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

  imports = with modules; useMods inputs [
    intel
    (niri.override {
      config_file = ./config/niri/niri.kdl;
    })
    bluetooth
    docker
    (quickshell.override {
      cwal_config = ../../config/cwal/cwal.ini;
      cwal_templates = ../../config/cwal/templates;
      quickshell_config = ../../config/quickshell;
    })
    (rofi.override {
      config_files = ../../config/rofi;
    })
    mako
    awww
    nautilus
    steam
    discord
    mprisence
    zenbrowser
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
