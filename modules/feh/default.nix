{
  config,
  pkgs,
  mkModule,
  lib,
  ...
}:
with lib;
let
  xorg = config.protocol.xorg.enable;
in
mkModule config "feh" {
  environment.packages = with pkgs; [ feh ];

  services.xserver.displayManager.sessionCommands = mkIf xorg ''
    if [ -f "${config.user_home}/.fehbg" ]; then
      ${config.user_home}/.fehbg ;
    fi
  '';
}
