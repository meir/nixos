{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = mkIf config.protocol.xorg.enable {
    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      desktopManager = {
        xterm.enable = true;
      };

      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };
  };
}
