{ config, lib, ... }:
with lib;
{
  options.modules.droidcam.enable = mkEnableOption "droidcam";

  config = mkIf config.modules.droidcam.enable {
    security.polkit.enable = true;
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

    programs.droidcam.enable = true;
  };
}
