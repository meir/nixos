{ pkgs, ... }:
let
  monado-start-desktop = pkgs.makeDesktopItem {
    exec = "monado-start";
    icon = "steamvr";
    name = "Start Monado";
    desktopName = "Start Monado";
    terminal = true;
  };
  audio_output = "Navi 31 HDMI/DP Audio Digital Stereo";
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
        lighthouse-steamvr
        lovr-playspace
      ];

    text = ''
      GROUP_PID_FILE="/tmp/monado-group-pid-$$"
      DEFAULT_SINK=$(pactl --format=json info | jq -r '.default_sink_name')

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
        pactl set-default-sink "$DEFAULT_SINK" &
        wait

        exit 0
      }

      function on() {
        echo "Starting Monado and other stuff..."

        lighthouse -vv --state on &
        systemctl --user restart monado.service

        setsid sh -c '
          # lovr-playspace &
          wlx-overlay-s --replace &
          wait
        ' &
        PGID=$!
        echo "$PGID" > "$GROUP_PID_FILE"

        sleep 10
        INDEX_SINK=$(pactl --format=json list sinks | jq -r '.[] |  select(.description | test("${audio_output}")) | .name')
        echo "Setting audio to $INDEX_SINK"
        pactl set-default-sink "$INDEX_SINK"

        sleep 5
        # weird issue i just cant solve in my nix/pw config, so this is the hack to fix it lol
        pw-metadata -n settings 0 clock.max-quantum 8192
        pw-metadata -n settings 0 clock.min-quantum 512
        pw-metadata -n settings 0 clock.force-rate 48000
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
