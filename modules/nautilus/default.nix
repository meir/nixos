{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule "nautilus" { environment.packages = with pkgs; [ gnome.nautilus ]; }
