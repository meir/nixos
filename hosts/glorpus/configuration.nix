{
  pkgs,
  modules,
  config,
  ...
}@inputs:
{
  # info
  user = "human";
  hostname = "glorpus";

  # apps
  environment.systemPackages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ vlc ];
      additionalLibs = [ vlc ];
    })
    spotify
    thunderbird
    stremio-linux-shell
  ];

  imports = with modules; useMods inputs [
    (niri.override {
      config_file = ./config/niri/niri.kdl;
    })
    bluetooth
    docker
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

  # config
  protocol = {
    autostart = [
      "thunderbird"
      "discord"
      "spotify"
    ];
  };
}
