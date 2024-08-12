{ options, lib, ... }:
with lib;
{
  imports = [
    ./xserver.nix
    ./picom.nix
    ./sxhkd.nix
    ./greeter.nix
    ./bspwm.nix
  ];
}
