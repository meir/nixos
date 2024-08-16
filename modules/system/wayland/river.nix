{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  buildRiver = pkgs.writeScript "init" (
    concatStringsSep "\n\n" (
      [ "#!/bin/sh" ]
      ++ config.protocol.rules
      ++ (mapAttrsToList (name: value: "riverctl map normal ${name} ${value}") config.protocol.hotkeys)
      ++ config.protocol.autostart
    )
  );
in
{
  config = mkIf config.protocol.wayland.enable {
    programs.river = {
      enable = true;

      xwayland.enable = true;
    };

    environment.file.river = {
      source = buildRiver;
      target = ".config/river/init";
    };

    protocol = {
      rules = [ "riverctl default-layout rivertile" ];
      hotkeys = {
        "Super Q" = "close";
        "Super+Shift Q" = "kill";
        "Super + T" = "tile";
        "Super + F" = "fullscreen";
        "Super + S" = "float";
      };
    };
  };
}
