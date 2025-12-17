{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  writeLaunchOptionsBin = appId: launchOptions:
    let
      launchCommand =
        if lib.strings.hasInfix "%command%" launchOptions then
          lib.replaceString "%command%" ''"$@"'' launchOptions
        else
          ''"$@" ${launchOptions}'';
    in
    writeWrapperBin appId "exec env ${launchCommand}";
in
{
  options.steam.apps = mkOption {
    type = types.attrsOf (types.submodule ({ name, ... }: {
      options = {
        id = mkOption {
          type = types.int;
          default = lib.strings.toIntBase10 name;
          example = 438100;
          description = "The Steam App ID of the application.";
        };

        shortcut = mkOption {
          
        };

        launchOptions = mkOption {
          type = nullOr (oneOf [
            package
            (coercedTo singleLineStr (writeLaunchOptionsBin config.id) package)
          ]);
          default = null;
          example = "-vulkan";
          description = "Additional launch options to pass to the application when started from Steam.";
        };

        proton = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "proton_experimental";
          description = "The Proton version to use for this application.";
        };
      };
    }));
    description = "An attribute set of applications to add to Steam launchoptions & shortcuts.";
    default = {};
  };
}
