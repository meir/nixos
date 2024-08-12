{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  buildSxhkd = pkgs.writeScript "sxhkdrc" (
    concatStringsSep "\n" (
      mapAttrsToList (name: value: ''
        ${name}
          ${value}
      '') config.protocol.hotkeys
    )
  );
in
{
  options.sxhkd.keybind = mkOption {
    type = types.attrsOf types.str;
    default = { };
  };

  config = mkIf config.protocol.xorg.enable {
    services.xserver.windowManager.bspwm.sxhkd.configFile = buildSxhkd;

    environment.defaultPackages = with pkgs; [ sxhkd ];

    protocol.hotkeys = {
      "shift + super + r" = ''
        pkill -x sxhkd && sxhkd &
      '';
    };

    environment.file.sxhkd = {
      source = buildSxhkd;
      target = ".config/sxhkd/sxhkdrc";
    };
  };
}
