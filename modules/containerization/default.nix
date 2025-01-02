{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.containerization.enable = mkEnableOption "containerization";

  config = mkIf config.modules.containerization.enable {
    virtualisation.docker.enable = true;

    virtualisation.libvirtd.enable = true;
    users.extraUsers."${config.user}".extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [ docker ];
  };
}
