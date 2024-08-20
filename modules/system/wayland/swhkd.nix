{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  buildHkdrc = pkgs.writeScript "hkdrc" (
    concatStringsSep "\n" (
      mapAttrsToList (name: value: ''
        ${name}
          ${value}
      '') config.protocol.hotkeys
    )
  );
in
{
  config = {
    environment.defaultPackages = with pkgs; [ swhkd ];

    protocol = {
      hotkeys = {
        "shift + super + r" = ''
          pkill -HUP swhkd
        '';
      };

      autoastart = [
        "swhks &"
        "pkexec swhkd &"
      ];
    };

    environment.file.swhkd = {
      source = buildHkdrc;
      target = ".config/swhkd/swhkdrc";
    };
  };
}
