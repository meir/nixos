{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.vm.enable = mkEnableOption "vm";

  config = mkIf config.modules.vm.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
      qemu
      OVMF
      pciutils
    ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.extraUsers."${config.user}".extraGroups = [ "libvirtd" ];

    boot = {
      kernelParams = [
        "amd_iommu=on"
        "iommu=pt"
      ];
      kernelModules = [
        "kvm-amd"
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
        "vfio_virqfd"
      ];
    };
  };
}
