{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  xorg = config.protocol.xorg.enable;
in
{
  options.modules.feh.enable = mkEnableOption "feh";

  config = mkIf (xorg && config.modules.feh.enable) {
    environment.systemPackages = with pkgs; [ feh ];

    protocol.autostart = mkIf xorg [
      "[ -f ${config.user_home}/.fehbg ] && ${config.user_home}/.fehbg"
    ];
  };
}
