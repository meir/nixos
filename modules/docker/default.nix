{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.docker.enable = mkEnableOption "docker";

  config = mkIf config.modules.docker.enable {
    virtualisation.docker.enable = true;

    virtualisation.libvirtd.enable = true;
    users.extraUsers."${config.user}".extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [ docker ];
  };
}
