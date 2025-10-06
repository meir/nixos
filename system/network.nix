{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options = {
    hostname = mkOption {
      type = types.str;
      default = "nixos";
      description = "Hostname of the machine";
    };
  };

  config = {
    networking = {
      networkmanager.enable = true;
      hostName = config.hostname;
      useDHCP = lib.mkDefault true;
      firewall = {
        enable = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
        allowPing = false;
      };
    };
  };
}
