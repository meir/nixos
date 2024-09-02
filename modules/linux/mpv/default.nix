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
    environment.packages = with pkgs; [ mpv ];

    environment.file.mpv = {
      source = ./mpv.conf;
      target = ".config/mpv/mpv.conf";
    };
  };
}
