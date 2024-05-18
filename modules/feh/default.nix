{ config, options, pkgs, lib, ... }:
with lib;
{
  options.modules.feh.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf config.modules.feh.enable {
    modules.packages = with pkgs; [
      feh
    ];

    system.activationScripts.homedirectory = stringAfter [ "users" "groups" ] ''
      if [ -d "${config.modules.user_home}/.fehbg" ] then
        ${config.modules.user_home}/.fehbg
      fi
    '';
  };
}
