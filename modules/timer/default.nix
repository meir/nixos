{
  config,
  pkgs,
  mkModule,
  lib,
  ...
}:
with lib;
mkModule config "timer" {
  environment.packages = with pkgs; [ timetrap ];

  protocol.hotkeys = {
    "super + t" = "${./timer.sh} toggle";
    "super + shift + t" = "${./timer.sh} view";
  };
}
