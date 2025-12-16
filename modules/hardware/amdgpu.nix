{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clinfo
    vulkan-tools
    vulkan-loader
    mesa
    btop-rocm
    amdgpu_top
    lact
    gamemode
  ];

  services.lact.enable = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "usbcore.autosuspend=-1"
    "usbcore.reset_resume=1"
    "usbcore.old_scheme_first=1"
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
}
