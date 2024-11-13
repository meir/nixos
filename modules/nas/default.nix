{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.nas.enable = mkEnableOption "Network Accessible Storage";

  config = mkIf config.modules.nas.enable {
    boot.kernelPackages = pkgs.linuxPackages;

    services.samba = {
      enable = true;
      package = pkgs.samba;
      securityType = "user"; # Use user-level security
      extraConfig = ''
        [global]
        workgroup = WORKGROUP
        server string = NixOS NAS Server
        netbios name = NIXOS-NAS
        map to guest = Bad User
        smb encrypt = required  # Enforce encryption for all connections
        passdb backend = tdbsam  # Use the TDB password database

        [shared]
        path = /srv/nas/shared
        browsable = yes
        writable = yes
        guest ok = no
        create mask = 0660
        directory mask = 0771
      '';
    };

    services.openssh = {
      enable = true;
      passwordAuthentication = false; # Disable password authentication
      permitRootLogin = "prohibit-password"; # Disable root login with password
      # Add your public keys here
      extraConfig = ''
        PubkeyAuthentication yes
        AuthorizedKeysFile .ssh/authorized_keys
      '';
    };

    # Ensure the shared directory exists with appropriate permissions
    systemd.tmpfiles.rules = [ "d /srv/nas/shared 0771 ${config.user} ${config.user} -" ];

    # Networking configuration
    networking.firewall.allowedTCPPorts = [
      139
      445
    ]; # Samba ports
    networking.firewall.allowedUDPPorts = [
      137
      138
    ]; # Samba ports
  };
}
