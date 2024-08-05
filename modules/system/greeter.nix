{
  config,
  options,
  pkgs,
  lib,
  ...
}:

with lib;
{
  config = {
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
