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
    environment.packages = with pkgs; [
      udev
      vial
      qmk
    ];

    services.udev.packages = with pkgs; [ vial ];
  };
}
