{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  buildBerry = pkgs.writeScript "berryc" (
    concatStringsSep "\n\n" ([ "$!/bin/sh" ] ++ config.berry.rules ++ config.berry.postScript)
  );
in
{
  options.berry = {
    rules = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    postScript = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = {
    services.xserver = {
      displayManager.sessionCommands = buildBerry;
      windowManager.berry = {
        enable = true;
      };
    };

    sxhkd.keybind = {
      # close, kill app
      "super + q" = ''
        berryc window_close
      '';

      # change mode
      "super + f" = ''
        berryc fullscreen 
      '';

      # move (node) to desktop
      "super + {_,shift + }{1-9,0}" = ''
        berryc {switch_workspace,send_to_workspace} '^{1-9,10}'
      '';
    };
  };
}
