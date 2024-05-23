{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.feh.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.feh.enable {
    modules.packages = with pkgs; [ feh ];

    services.xserver.displayManager.sessionCommands = ''
      if [ -f "${config.user_home}/.fehbg" ]; then
        ${config.user_home}/.fehbg ;
      fi
    '';
  };
}
