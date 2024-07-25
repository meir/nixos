{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  services.picom = {
    enable = true;
    package = pkgs.picom-ftlabs;

    vSync = true;

    settings = {
      backend = "glx";

      blur = {
        method = "dual_kawase";
        strength = 10;
        background = true;
        background-frame = false;
        background-fixed = false;
      };
    };
  };
}
