{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
mkModule "qmk" {
  environment.packages = with pkgs; [
    udev
    vial
    qmk
  ];

  services.udev.packages = with pkgs; [ vial ];
}
