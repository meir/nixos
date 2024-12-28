{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.lact.enable = mkEnableOption "lact";

  config = mkIf config.modules.lact.enable {
    environment.systemPackages = with pkgs; [ lact ];
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  };
}
