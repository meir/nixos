{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
  ];

  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  programs.droidcam.enable = true;
}
