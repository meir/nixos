{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule "rofi" {
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
