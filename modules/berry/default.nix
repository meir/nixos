{ config, options, pkgs, lib, ... }:
with lib; {
  services.xserver.windowManager.berry = { enable = true; };

  modules.packages = with pkgs; [ sxhkd ];

  services.xserver.displayManager.sessionCommands = ''
    sxhkd &
    berryc move_mask "mod4"
    berryc move_button 1
    berryc resize_mask "mod4"
    berryc resize_button 3
  '';

  environment.file.sxhkd = {
    source = ./sxhkdrc;
    target = ".config/sxhkd/sxhkdrc";
  };
}
