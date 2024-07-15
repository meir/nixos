{
  options,
  config,
  pkgs,
  mkModule,
  ...
}:
let
  name = "rofi";
in
{
  options.modules."${name}".source = {
    type = lib.types.path;
    default = null;
  };
}
// mkModule config "${name}" {
  environment.packages = with pkgs; [
    rofi
    clipcat
  ];

  sxhkd.keybind = {
    "super + @space" = "rofi -show drun";
    "shift + super + v" = "clipcat-menu";
  };

  environment.file.rofi = lib.mkIf config.modules."${name}".source {
    source = config.modules."${name}".source;
    target = ".config/rofi";
  };

  services.clipcat.enable = true;
  environment.file.clipcat = {
    source = ./clipcatd.toml;
    target = ".config/clipcat/clipcatd.toml";
  };
}
