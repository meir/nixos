{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.timer.enable = mkEnableOption "timetrap";

  config = mkIf config.modules.timer.enable {
    environment.systemPackages = with pkgs; [ timetrap ];

    protocol.hotkeys = {
      "alt + t" = "${./timer.sh} toggle";
      "alt + shift + t" = "${./timer.sh} view";
    };
  };
}
