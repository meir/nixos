{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.mpv.enable = mkEnableOption "mpv";

  config = mkIf config.modules.mpv.enable {
    environment.systemPackages = with pkgs; [ mpv ];

    environment.file.mpv = {
      source = ../../../config/mpv/mpv.conf;
      target = ".config/mpv/mpv.conf";
    };
  };
}
