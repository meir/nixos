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
      displayManager = {
        lightdm = {
          enable = true;

          greeters.gtk = {
            enable = true;

            theme = {

            };
          };

          extraConfig = ''

          '';
        };
      };
    };
  };
}
