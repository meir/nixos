{ config, lib, ... }:
with lib;
{
  options.modules.discord.enable = mkEnableOption "discord";

  config = mkIf config.modules.discord.enable {
    environment.systemPackages = with pkgs; [
      discord_wayland
    ];

    security.polkit.enable = true;
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

    programs.droidcam.enable = true;
  };
}
