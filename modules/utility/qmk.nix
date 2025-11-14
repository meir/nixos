{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    udev
    vial
    qmk
  ];

  services.udev.packages = with pkgs; [ vial ];
}
