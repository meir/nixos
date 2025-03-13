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
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];

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

    hardware.opengl.extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];

    hardware.opengl.extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];

    hardware.graphics.enable32Bit = true;
    hardware.amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      amdvlk.enable = false;
    };
  };
}
