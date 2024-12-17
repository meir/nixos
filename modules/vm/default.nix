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
      type = types.listOf types.str;
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
      OVMF
    ];

    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.users.${config.user}.extraGroups = [
      "libvirtd"
      "kvm"
    ];

    boot = {
      kernelParams = [
        "amd_iommu=on"
        "iommu=pt"
        "vfio_iommu_type1.allow_unsafe_interrupts=1"
      ];

      kernelModules = [
        "kvm-amd"
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
      ];

      extraModprobeConfig = optionalString (config.modules.vm.pciIds != [ ]) ''
        options vfio-pci ids=${concatStringsSep "," config.modules.vm.pciIds}
      '';
    };

    boot.blacklistedKernelModules = [
      "nouveau"
      "nvidia"
    ];

    systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 ${config.user} kvm -" ];
  };
}
