{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule "qmk" {
  environment.packages = with pkgs; [
    udev
    vial
    qmk
  ];

  services.udev.packages = with pkgs; [ vial ];
}
