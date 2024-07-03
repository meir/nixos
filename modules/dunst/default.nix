{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
mkModule "dunst" { environment.packages = with pkgs; [ dunst ]; }
