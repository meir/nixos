{ config, options, pkgs, lib, ... }:
with lib; {
  services.xserver.windowManager.berry = { enable = true; };

  modules.packages = [ sxhkd ];

  services.xserver.displayManager.sessionCommands = ''
    sxhkd &
  '';
}
