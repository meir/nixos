{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  buildRiver = pkgs.writeScript "init" (
    concatStringsSep "\n\n" ([ "#!/bin/sh" ] ++ config.protocol.rules ++ config.protocol.autostart)
  );
  binary = str: "$((2#${str}))";
in
{
  config = mkIf config.protocol.wayland.enable {
    environment.systemPackages = with pkgs; [ river ];

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
        "super + {_,shift +} {1-9,0}" = "riverctl {set-focused-tags,set-view-tags} $((1<<({1-9,10}-1)))";
      };
    };
  };
}
