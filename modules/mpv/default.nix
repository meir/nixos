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

    hm.home.file.".config/mpv/mpv.conf" = {
      source = ../../config/mpv/mpv.conf;
    };
  };
}