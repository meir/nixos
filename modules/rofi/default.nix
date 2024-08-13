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
  xorg = config.protocol.xorg.enable;
  wayland = config.protocol.wayland.enable;
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

    protocol.hotkeys = {
      "super + {_,shift +} @space" = "rofi -show {drun,run} &";
      "shift + super + v" = ''clipcat-menu && xdotool key --clearmodifiers "ctrl+v"'';
    };

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
