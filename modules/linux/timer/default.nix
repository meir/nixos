{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
pkgs.mkModule config "timer" {
  environment.packages = with pkgs; [ timetrap ];

  protocol.hotkeys = {
    "alt + t" = "${./timer.sh} toggle";
    "alt + shift + t" = "${./timer.sh} view";
  };
}
