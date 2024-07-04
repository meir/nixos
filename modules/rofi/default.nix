{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "rofi" {
  environment.packages = with pkgs; [
    rofi
    clipcat
  ];

  sxhkd.keybind = {
    "super + @space" = "rofi -show drun";
    "shift + super + v" = "clipcat-menu";
  };

  environment.file.rofi = {
    source = ./rofi;
    target = ".config/rofi";
  };

  services.clipcat.enable = true;
  environment.file.clipcat = {
    source = ./clipcatd.toml;
    target = ".config/clipcat/clipcatd.toml";
  };
}
