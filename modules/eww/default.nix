{
  lib,
  config,
  pkgs,
  options,
  mkModule,
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

mkModule config "${name}" {
  options.modules."${name}" = {
    source = mkOption {
      type = types.nullOr types.path;
      default = null;
    };

    widgets = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = {
    environment.packages = with pkgs; [ eww ];

    protocol.autostart = [
      ''
        ${pkgs.eww}/bin/eww daemon &
        ${widgetScripts}
      ''
    ];

    environment.file.eww = mkIf (config.modules."${name}".source != null) {
      source = config.modules."${name}".source;
      target = ".config/eww";
    };
  };
}
