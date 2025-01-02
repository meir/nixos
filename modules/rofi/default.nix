{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  name = "rofi";
in
{
  options.modules."${name}" = {
    enable = mkEnableOption "${name}";
    source = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  };

  config = mkIf config.modules."${name}".enable {
    environment.systemPackages = with pkgs; [
      rofi
      cliphist
    ];

    protocol.hotkeys = [
      ''
        super + {_,shift +} Space
          hyprland | exec, rofi -show {drun,run} &
          rofi -show {drun,run} &

        # paste
        super + v
          hyprland | exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      ''
    ];

    protocol.autostart = [
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
  };
}
