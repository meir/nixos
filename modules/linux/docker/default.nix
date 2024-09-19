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
    users.extraUsers.youruser.extraGroups = [ "libvirtd" ];

    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';

    environment.systemPackages = with pkgs; [ docker ];
  };
}
