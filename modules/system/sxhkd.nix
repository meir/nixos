{ config, options, pkgs, lib, ... }:
with lib;
let
  buildSxhkd = pkgs.writeScript "sxhkdrc" (concatStringsSep "\n" (mapAttrsToList
    (name: value: ''
      ${name}
        ${value}
    '') config.sxhkd.keybind));
in {
  options.sxhkd.keybind = mkOption {
    type = types.attrsOf types.str;
    default = { };
  };

  config = {
    environment.packages = with pkgs; [ sxhkd ];
    services.xserver.displayManager.sessionCommands = ''
      sxhkd -c ${buildSxhkd} &
    '';
  };
}
