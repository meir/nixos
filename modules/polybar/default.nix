{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.polybar.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.polybar.enable {
    environment.packages = with pkgs; [ polybar ];

    systemd.user.services.polybar = {
      enable = true;
      path = [
        pkgs.polybar
        pkgs.coreutils
        pkgs.dbus
        pkgs.gnugrep
        pkgs.xorg.xrandr
        pkgs.procps
      ];
      unitConfig = {
        PartOf = [ "graphical-session.target" ];
        X-Restart-Triggers = [ "${config.environment.file.polybar.source}" ];
      };
      wantedBy = [ "graphical-session.target" ];
      description = "Polybar";
      serviceConfig = let
        scriptPkg = pkgs.writeShellScriptBin "polybar-start" ''
          ${pkgs.polybar}/bin/polybar mon0 &
          ${pkgs.polybar}/bin/polybar mon1 &
        '';
      in {
        Type = "forking";
        ExecStart = "${scriptPkg}/bin/polybar-start";
        Restart = "on-failure";
      };
    };

    environment.file.polybar = {
      source = ./polybar;
      target = ".config/polybar";
    };
  };
}
