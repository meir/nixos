{
  lib,
  config,
  pkgs,
  options,
  mkModule,
  ...
}:
let
  name = "eww";

  widgetScripts = pkgs.writeScript "eww-start" (
    concatStringsSetp "\n" (
      map (widget: ''
        ${pkgs.eww}/bin/eww open ${widget}
      '') config.modules."${name}".widgets
    )
  );
in
{
  options.modules."${name}".source = lib.mkOption {
    type = lib.types.path;
    default = null;
  };

  options.modules."${name}".widgets = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = [ ];
  };
}
// mkModule config "${name}" {
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

  environment.file.eww = lib.mkIf config.modules."${name}".source {
    source = config.modules."${name}".source;
    target = ".config/eww";
  };
}
