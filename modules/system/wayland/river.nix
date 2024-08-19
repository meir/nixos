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
        "Super Q" = "close";
        "Super+Shift Q" = "kill";
        "Super+Shift R" = "~/.config/river/init";
        "Super + T" = "tile";
        "Super + F" = "fullscreen";
        "Super + S" = "float";
        "Super 1" = "set-focused-tags ${binary "0000000001"}";
        "Super 2" = "set-focused-tags ${binary "0000000010"}";
        "Super 3" = "set-focused-tags ${binary "0000000100"}";
        "Super 4" = "set-focused-tags ${binary "0000001000"}";
        "Super 5" = "set-focused-tags ${binary "0000010000"}";
        "Super 6" = "set-focused-tags ${binary "0000100000"}";
        "Super 7" = "set-focused-tags ${binary "0001000000"}";
        "Super 8" = "set-focused-tags ${binary "0010000000"}";
        "Super 9" = "set-focused-tags ${binary "0100000000"}";
        "Super 0" = "set-focused-tags ${binary "1000000000"}";
        "Super+Shift 1" = "set-view-tags ${binary "0000000001"}";
        "Super+Shift 2" = "set-view-tags ${binary "0000000010"}";
        "Super+Shift 3" = "set-view-tags ${binary "0000000100"}";
        "Super+Shift 4" = "set-view-tags ${binary "0000001000"}";
        "Super+Shift 5" = "set-view-tags ${binary "0000010000"}";
        "Super+Shift 6" = "set-view-tags ${binary "0000100000"}";
        "Super+Shift 7" = "set-view-tags ${binary "0001000000"}";
        "Super+Shift 8" = "set-view-tags ${binary "0010000000"}";
        "Super+Shift 9" = "set-view-tags ${binary "0100000000"}";
        "Super+Shift 0" = "set-view-tags ${binary "1000000000"}";
      };
    };
  };
}
