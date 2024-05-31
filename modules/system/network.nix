{ config, pkgs, lib, ... }: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 ];
      allowedUDPPorts = [ 443 80 ];
      allowPing = false;
    };
  };
}
