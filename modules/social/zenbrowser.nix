{ pkgs, ... }:
let
  pywalfoxUpdateHandleSocket = pkgs.writeShellScript "pywalfox-update-handle-socket" ''
    set -euo pipefail

    sock=/tmp/pywalfox_socket
    if [ ! -S "$sock" ]; then
      rm -f $sock 2>/dev/null
    fi

    exec ${pkgs.pywalfox-native} update
  '';
in
{
  environment.systemPackages = with pkgs; [
    zen-browser
    pywalfox-native
  ];

  systemd.user.services.pywalfox-update = {
    Unit = {
      Description = "Update Pywalfox theme";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = pywalfoxUpdateHandleSocket;
      PrivateTmp = false;
    };
  };

  systemd.user.paths.pywalfox-update = {
    Unit = {
      Description = "Run pywalfox update when wal colors.json changes";
      PartOf = [ "graphical-session.target" ];
    };
    Path = {
      PathChanged = "%h/.cache/cwal/colors.json";
      Unit = "pywalfox-update.service";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.mime.defaultApplications = {
    "text/html" = "zenbrowser.desktop";
    "x-scheme-handler/http" = "zenbrowser.desktop";
    "x-scheme-handler/https" = "zenbrowser.desktop";
  };
}
