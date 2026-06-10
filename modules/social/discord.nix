{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    (unstable.discord.override {
      withOpenASAR = false;
      withVencord = true;
    })
  ];

  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  programs.droidcam.enable = true;
}
