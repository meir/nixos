{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule "dunst" { environment.packages = with pkgs; [ dunst ]; }
