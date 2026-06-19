{ pkgs, VR_HEADSET_SINK ? "", ... }:
let
  monado-start-desktop = pkgs.makeDesktopItem {
    exec = "monado-start";
    icon = "steamvr";
    name = "Start Monado";
    desktopName = "Start Monado";
    terminal = true;
  };
in
pkgs.stdenv.mkDerivation {
  pname = "monado-start";
  version = "3.1.0";

  src = pkgs.writeShellApplication {
    name = "monado-start";

    runtimeInputs =
      with pkgs;
      [
        unstable.wayvr
        lighthouse-steamvr
        xr-chaperone
        libsnout
      ];

    text = ''
      GROUP_PID_FILE="/tmp/monado-group-pid-$$"
      DEFAULT_SINK=$(pactl --format=json info | jq -r '.default_sink_name')
      QUITTING=0

      function off() {
        if [ "$QUITTING" -eq 1 ]; then
          return
        fi
        QUITTING=1

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
        VR_HEADSET_SINK="${VR_HEADSET_SINK}"
        if [ -n "$VR_HEADSET_SINK" ]; then
          echo "Looking for sink matching description '${VR_HEADSET_SINK}'..."
          VR_SINK=$(pactl --format=json list sinks | jq -r '.[] | select(.description | test("${VR_HEADSET_SINK}")) | .name')
          echo "Setting default sink to $VR_SINK..."
          pactl set-default-sink "$VR_SINK" &
        else
          echo "No VR_HEADSET_SINK provided, using default sink."
        fi

        setsid sh -c '
          xr-chaperone -s &
          wayvr --replace &
          snout-cli --config ~/.config/snout/snout.toml &
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
