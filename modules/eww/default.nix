{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  widgetScripts = pkgs.writeScript "eww-start" (
    concatStringsSep "\n" (
      map (widget: ''
        ${pkgs.eww}/bin/eww open ${widget}
      '') config.modules.eww.widgets
    )
  );
in
{
  options.modules.eww = {
    enable = mkEnableOption eww;

    source = mkOption {
      type = types.nullOr types.path;
      default = null;
    };

    widgets = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf config.modules.eww.enable {
    environment.systemPackages = with pkgs; [
      eww
      zscroll
    ];

    protocol.autostart = [
      "${pkgs.eww}/bin/eww daemon &"
      "${widgetScripts}"
    ];
  };
}
