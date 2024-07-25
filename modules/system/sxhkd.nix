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
      '') config.sxhkd.keybind
    )
  );
in
{
  options.sxhkd.keybind = mkOption {
    type = types.attrsOf types.str;
    default = { };
  };

  config = {
    services.xserver.windowManager.bspwm.sxhkd.configFile = buildSxhkd;
    environment.file.sxhkd = {
      source = buildSxhkd;
      target = ".config/sxhkd/sxhkdrc";
    };
  };
}
