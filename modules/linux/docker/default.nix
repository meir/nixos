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

    boot = {
      extraModprobeConfig = ''
        options vfio-pci ids=1002:67df,1002:aaf0
        options kvm_amd nested=1
        options kvm ignore_msrs=1
      '';

      kernelParams = [ "amd_iommu=on" ];
      kernelModules = [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
        "vfio_virqfd"
        "kvm"
        "kvm_amd"
      ];
    };

    environment.systemPackages = with pkgs; [
      docker
      osx-kvm
    ];
  };
}
