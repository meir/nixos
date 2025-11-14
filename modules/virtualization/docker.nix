{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;
  users.extraUsers."${config.user}".extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [ docker ];
}
