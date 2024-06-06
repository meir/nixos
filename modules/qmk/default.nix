{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.qmk.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.qmk.enable {
    environment.packages = with pkgs; [
      udev
      vial
      qmk
    ];

    services.udev.packages = with pkgs; [ vial ];
  };
}
