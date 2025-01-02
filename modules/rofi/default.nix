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
    ];

    protocol.hotkeys = [
      ''
        super + {_,shift +} Space
          hyprland | exec, rofi -show {drun,run} &
          rofi -show {drun,run} &
      ''
    ];
  };
}
