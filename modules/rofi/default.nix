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
      clipcat
    ];

    protocol.hotkeys = [
      ''
        super + {_,shift +} Space
          hyprland | exec, rofi -show {drun,run} &
          rofi -show {drun,run} &
      ''
      ''
        shift + super + v
          hyprland | exec, echo "not implemented yet"
          clipcat-menu && xdotool key --clearmodifiers "ctrl+v"
      ''
    ];

    services.clipcat.enable = true;

    hm.home.file = mkIf (config.modules."${name}".source != null) {
      ".config/rofi" = {
        source = config.modules."${name}".source;
      };
      ".config/clipcat" = {
        source = ../../config/clipcat;
      };
    };
  };
}
