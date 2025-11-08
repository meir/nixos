{ pkgs, ... }:
let
  monado-start-desktop = pkgs.makeDesktopItem {
    exec = "monado-start";
    icon = "steamvr";
    name = "Start Monado";
    desktopName = "Start Monado";
    terminal = true;
  };
  audio-connector = pkgs.writeScript "connect-index-audio" ''
    #!/usr/bin/env bash
      set -euo pipefail
      sleep 1
      DEFAULT_SINK=$(pactl info | awk -F': ' '/Default Sink/ {print $2}' | tr -d '\r\n')
      if [ -z "$${DEFAULT_SINK}" ]; then
        echo "pipewire-copy-to-index: no default sink found, exiting" >&2
        exit 0
      fi
      INDEX_SINK=$(pactl list short sinks \
        | awk '{print $2 " " $0}' \
        | grep -Ei 'valve|index|hdmi' \
        | awk '{print $1}' \
        | head -n1 || true)
      if [ -z "$${INDEX_SINK}" ]; then
        echo "pipewire-copy-to-index: no Index sink found (tried Valve/Index/HDMI), exiting" >&2
        exit 0
      fi
      if [ "$DEFAULT_SINK" = "$INDEX_SINK" ]; then
        echo "pipewire-copy-to-index: default sink is already Index, nothing to do" >&2
        exit 0
      fi
      echo "pipewire-copy-to-index: connecting $${DEFAULT_SINK}.monitor -> $${INDEX_SINK}" >&2
      exec pw-loopback "$${DEFAULT_SINK}.monitor" "$${INDEX_SINK}"
  '';
in
pkgs.stdenv.mkDerivation {
  pname = "monado-start";
  version = "3.1.0";

  src = pkgs.writeShellApplication {
    name = "monado-start";

    runtimeInputs =
      with pkgs;
      [
        wlx-overlay-s
        wayvr-dashboard
        # index_camera_passthrough
        lighthouse-steamvr
        kdePackages.kde-cli-tools
      ]
      ++ [
        lovr-playspace
      ];

    text = ''
      GROUP_PID_FILE="/tmp/monado-group-pid-$$"

      function off() {
        echo "Stopping Monado and other stuff..."

        if [ -f "$GROUP_PID_FILE" ]; then
          PGID=$(cat "$GROUP_PID_FILE")
          echo "Killing process group $PGID..."
          kill -- -"$PGID" 2>/dev/null
          rm -f "$GROUP_PID_FILE"
        fi

        systemctl --user stop monado.service &
        lighthouse -vv --state off &
        wait

        exit 0
      }

      function on() {
        echo "Starting Monado and other stuff..."

        lighthouse -vv --state on &
        systemctl --user restart monado.service

        setsid sh -c '
          lovr-playspace &
          wlx-overlay-s --replace &
          ${audio-connector} &
          wait
        ' &
        PGID=$!
        echo "$PGID" > "$GROUP_PID_FILE"
      }

      trap off EXIT INT TERM
      echo "Press ENTER to turn everything OFF."

      on
      read -r
      off
    '';
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/monado-start $out/bin/
    chmod +x $out/bin/monado-start

    cp -r ${monado-start-desktop}/* $out/
  '';

  meta = {
    description = "Start script for monado and all other things i use with it.";
  };
}
