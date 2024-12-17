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

    virtualisation.libvirtd.qemu.verbatimConfig = ''
      nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
      spice_gl = 1
      gfx_gl = 1
    '';
  };
}
