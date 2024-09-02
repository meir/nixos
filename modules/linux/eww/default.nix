{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  name = "eww";

  widgetScripts = pkgs.writeScript "eww-start" (
    concatStringsSep "\n" (
      map (widget: ''
        ${pkgs.eww}/bin/eww open ${widget}
      '') config.modules."${name}".widgets
    )
  );
in
{
  options.modules."${name}" = {
    enable = mkEnableOption "${name}";

    source = mkOption {
      type = types.nullOr types.path;
      default = null;
    };

    widgets = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf config.modules."${name}".enable {
    environment.packages = with pkgs; [
      eww
      zscroll
    ];

    protocol.autostart = [
      "${pkgs.eww}/bin/eww daemon &"
      "${widgetScripts}"
    ];

    environment.file.eww = mkIf (config.modules."${name}".source != null) {
      source = config.modules."${name}".source;
      target = ".config/eww";
    };
  };
}