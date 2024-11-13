{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.vfio = {
    enable = mkEnableOption "vfio";
    pci_ids = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [
        "1002:67df"
        "1002:aaf0"
      ];
      description = ''
        List of PCI IDs to bind to vfio-pci.
      '';
    };
  };

  config = mkIf config.modules.vfio.enable {
    # virtualisation.libvirtd = {
    #   enable = true;
    #   onBoot = "ignore";
    #   onShutdown = "shutdown";
    #   qemu = {
    #     ovmf.enable = true;
    #     runAsRoot = true;
    #   };
    # };
    #
    # programs.dconf.profiles.user.databases = [
    #   {
    #     lockAll = true;
    #
    #     settings = {
    #       "org/virt-manager/virt-manager/connections" = {
    #         autoconnect = [ "qemu:///system" ];
    #         uris = [ "qemu:///system" ];
    #       };
    #     };
    #   }
    # ];
    #
    # programs.virt-manager.enable = true;
    # users.extraUsers."${config.user}".extraGroups = [ "libvirtd" ];
    #
    # boot =
    #   let
    #     ids = lib.concatStringsSep "," config.modules.vfio.pci_ids;
    #   in
    #   {
    #     extraModprobeConfig = ''
    #       options vfio-pci ids=${ids}
    #       options kvm_amd nested=1
    #       options kvm_amd emulate_invalid_guest_state=0
    #       options kvm ignore_msrs=1
    #     '';
    #
    #     kernelParams = [
    #       "amd_iommu=on"
    #       "iommu=pt"
    #       "vfio-pci.ids=${ids}"
    #     ];
    #     kernelModules = [
    #       "vfio"
    #       "vfio_iommu_type1"
    #       "vfio_pci"
    #       "vfio_virqfd"
    #       "kvm"
    #       "kvm_amd"
    #     ];
    #   };

    environment.systemPackages = with pkgs; [
      pciutils
      virt-manager
      quickemu
    ];
  };
}
