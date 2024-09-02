{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
pkgs.mkModule config "mpv" {
  environment.packages = with pkgs; [ mpv ];

  environment.file.mpv = {
    source = ./mpv.conf;
    target = ".config/mpv/mpv.conf";
  };
}
