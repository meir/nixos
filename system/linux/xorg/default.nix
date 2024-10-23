{ options, lib, ... }:
with lib;
{
  imports = [
    ./xserver.nix
    ./picom.nix
    ./greeter.nix
    ./bspwm.nix
    ./sxhkd.nix
    ./gnome.nix
  ];
}
