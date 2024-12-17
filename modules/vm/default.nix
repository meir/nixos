{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.vm = {
    enable = mkEnableOption "vm";
    pciIds = mkOption {
      type = types.listOf types.string;
      default = [
        "10de:XXXX"
        "10de:YYYY"
      ];
      description = "List of PCI IDs to passthrough to the VM";
    };
  };

  config = mkIf config.modules.vm.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
      looking-glass-client
      pciutils
    ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.extraUsers."${config.user}".extraGroups = [ "libvirtd" ];

    boot = {
      kernelParams = [
        "amd_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=${toString config.modules.vm.pciIds}"
      ];
      kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "vfio_virqfd"
      ];
      blacklistedKernelModules = [
        "nvidia"
        "nouveau"
      ];
    };
  };
}
