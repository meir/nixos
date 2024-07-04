{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "eww" {
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
          ${pkgs.eww}/bin/polybar mon0 &
          ${pkgs.eww}/bin/polybar mon1 &
        '';
      in
      {
        Type = "forking";
        ExecStart = "${scriptPkg}/bin/eww-start";
        Restart = "on-failure";
      };
  };

  environment.file.eww = {
    source = ./eww;
    target = ".config/eww";
  };
}
