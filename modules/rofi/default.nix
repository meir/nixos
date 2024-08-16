{
  lib,
  options,
  config,
  pkgs,
  mkModule,
  ...
}:
with lib;
let
  name = "rofi";
  hotkeys = {
    xorg = {
      "super + {_,shift +} @space" = "rofi -show {drun,run} &";
      "shift + super + v" = ''clipcat-menu && xdotool key --clearmodifiers "ctrl+v"'';
    };
    wayland = {
      "Super Space" = "rofi -show drun &";
      "Super+Shift Space" = "rofi -show run &";
      "Super+Shift V" = "clipcat-menu";
    };
  };
in
mkModule config "${name}" {
  options.modules."${name}".source = mkOption {
    type = types.nullOr types.path;
    default = null;
  };

  config = {
    environment.packages = with pkgs; [
      rofi
      clipcat
    ];

    protocol.hotkeys = hotkeys."${config.protocol.type}";

    environment.file.rofi = mkIf (config.modules."${name}".source != null) {
      source = config.modules."${name}".source;
      target = ".config/rofi";
    };

    services.clipcat.enable = true;
    environment.file.clipcat = {
      source = ./clipcat;
      target = ".config/clipcat";
    };
  };
}
