{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    (unstable.discord.override {
      withVencord = true;
    })
  ];

  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  programs.droidcam.enable = true;
}
