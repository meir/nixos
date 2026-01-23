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
  ];

  imports = with modules; useMods inputs [
    (niri.override {
      config_file = ./config/niri/niri.kdl;
    })
    bluetooth
    docker
    (eww.override {
      config_files = ./config/eww;
      widgets = [ "laptop" ];
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
    discord
    mprisence
    zenbrowser
    neovim
    onepassword
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
  protocol = {
    autostart = [
      "thunderbird"
      "discord"
      "spotify"
    ];
  };
}
