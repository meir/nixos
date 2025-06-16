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
      mesa
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

    powerManagement.cpuFreqGovernor = "performance";

    hardware.graphics.enable32Bit = true;
    hardware.amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };
}
