{
  config,
  pkgs,
  lib,
  ...
}:
{
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
      allowPing = false;
    };
  };
}
