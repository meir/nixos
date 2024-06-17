{ pkgs, ... }:
{
  config = {
    user = "human";

    bspwm.rules = [
      "bspc wm -O HDMI-1 DP-2"
      "bspc monitor HDMI-1 -d 1 2 3 4 5"
      "bspc monitor DP-2 -d 6 7 8 9 10"
    ];
  };
}
