{
  config,
  options,
  lib,
  ...
}:
let
  xorg = config.protocol.xorg.enable;
  wayland = config.protocol.wayland.enable;
in
with lib;
{
  imports = [
    (mkIf xorg ./xorg.nix)
    (mkIf wayland ./wayland.nix)
  ];
}
