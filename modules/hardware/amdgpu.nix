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

  systemd.services.lactd = {
    enable = true;
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lactd daemon";
    };
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
  };

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
}
