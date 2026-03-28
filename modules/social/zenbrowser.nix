{ pkgs, lib, ... }:
let
  pywalfoxUpdateHandleSocket = pkgs.writeShellScript "pywalfox-update-handle-socket" ''
    set -euo pipefail

    sock=/tmp/pywalfox_socket
    if [ ! -S "$sock" ]; then
      rm -f $sock 2>/dev/null
    fi

    exec ${lib.getExe pkgs.pywalfox-native} update
  '';
in
{
  environment.systemPackages = with pkgs; [
    zen-browser
    pywalfox-native
  ];

  systemd.user.services.pywalfox-update = {
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pywalfoxUpdateHandleSocket;
      PrivateTmp = false;
    };
  };

  systemd.user.paths.pywalfox-update = {
    wantedBy = [ "graphical-session.target" ];
    pathConfig = {
      PathChanged = "%h/.cache/cwal/colors.json";
      Unit = "pywalfox-update.service";
    };
  };

  xdg.mime.defaultApplications = {
    "text/html" = "zenbrowser.desktop";
    "x-scheme-handler/http" = "zenbrowser.desktop";
    "x-scheme-handler/https" = "zenbrowser.desktop";
  };
}
