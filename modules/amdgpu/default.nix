{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.amdgpu.enable = mkEnableOption "AMD Drivers";

  config = mkIf config.modules.amdgpu.enable {
    environment.systemPackages = with pkgs; [
      clinfo
      vulkan-tools
      vulkan-loader
      mesa.drivers
      gamemode
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    systemd.tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      [
        "L+    /opt/rocm/hip   -    -    -     -    ${rocmEnv}"
      ];

    hardware.graphics.enable = true;

    boot.kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
    };

    powerManagement.cpuFreqGovernor = "performance";

    hardware.graphics.extraPackages = with pkgs; [
      rocmPackages.clr.icd
      # amdvlk
    ];

    # hardware.opengl.extraPackages32 = with pkgs; [
    #   driversi686Linux.amdvlk
    # ];

    hardware.graphics.enable32Bit = true;
    hardware.amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      amdvlk.enable = false;
    };
  };
}
