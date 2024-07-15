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
recursiveUpdate
  {
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
  }
  (
    mkModule config "${name}" {
      environment.packages = with pkgs; [ eww ];

      systemd.user.services.eww = {
        enable = true;
        path = [
          pkgs.eww
          pkgs.coreutils
          pkgs.dbus
          pkgs.gnugrep
          pkgs.xorg.xrandr
          pkgs.procps
        ];
        unitConfig = {
          PartOf = [ "graphical-session.target" ];
          X-Restart-Triggers = [ "${config.environment.file.eww.source}" ];
        };
        wantedBy = [ "graphical-session.target" ];
        description = "Eww";
        serviceConfig =
          let
            scriptPkg = pkgs.writeShellScriptBin "eww-start" ''
              ${pkgs.eww}/bin/eww daemon &
              ${widgetScripts}
            '';
          in
          {
            Type = "forking";
            ExecStart = "${scriptPkg}/bin/eww-start";
            Restart = "on-failure";
          };
      };

      environment.file.eww = mkIf (config.modules."${name}".source != null) {
        source = config.modules."${name}".source;
        target = ".config/eww";
      };
    }
  )
