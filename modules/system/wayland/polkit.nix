{ lib, ... }:
with lib;
{
  config = mkIf config.protocol.wayland.enable { security.polkit.enable = true; };
}
