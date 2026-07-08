{
  pkgs,
  cachyos,
  ...
}:
{
  nixpkgs.overlays = [
    cachyos.overlays.pinned
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-rc;
}
