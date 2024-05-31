{ config, options, pkgs, lib, ... }:
let
  buildSxhkd = pkgs.writeScript "sxhkdrc" (lib.concatStringsSep "\n"
    (mapAttrsToList (name: value: ''
      ${name}
      	${value}'') options.sxhkd.keybind));
in with lib; {
  options.sxhkd.keybind = mkOption {
    type = types.attrsOf types.string;
    default = { };
  };

  config = mkIf options.sxhkd.enable {
    environment.packages = [ sxhkd ];
    services.xserver.displayManager.sessionCommands = ''
      sxhkd -c ${buildSxhkd} &
    '';
  };
}
