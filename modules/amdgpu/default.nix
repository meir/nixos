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
      "amdgpu.dc=0"
      "amdgpu.noretry=0"
      "radeon.si_support=0"
      "amdgpu.si_support=1"
    ];

    environment.variables = {
      MESA_NO_ERROR = "1";
      MESA_GL_VERSION_OVERRIDE = "4.5";
      MESA_GLSL_VERSION_OVERRIDE = "450";
      __GL_THREADED_OPTIMIZATIONS = "1";
      mesa_glthread = "true";
      R600_DEBUG = "nohyperz,nosb";
    };

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
      rocmPackages.rocm-runtime
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
