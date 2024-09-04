{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.qmk.enable = mkEnableOption "qmk";

  config = mkIf config.modules.qmk.enable {
    environment.systemPackages = with pkgs; [
      udev
      vial
      qmk
    ];

    services.udev.packages = with pkgs; [ vial ];
  };
}
