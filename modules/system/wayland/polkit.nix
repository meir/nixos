{ ... }:
{
  config = mkIf config.protocol.xorg.enable { security.polkit.enable = true; };
}
