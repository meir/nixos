{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules = {
    discord.enable = mkEnableOption "discord";
    qutebrowser.enable = mkEnableOption "qutebrowser";
  };

  config = (
    mkMerge [
      mkIf
      config.modules.discord.enable
      {
        environment.systemPackages = with pkgs; [
          discord_wayland
        ];

        security.polkit.enable = true;
        boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

        programs.droidcam.enable = true;
      }

      mkIf
      config.moduels.qutebrowser.enable
      {
        environment.systemPackages = with pkgs; [
          qutebrowser
          jq
        ];

        hm.home.file.".config/qutebrowser".source = ../config/qutebrowser;

        xdg.mime.defaultApplications = {
          "text/html" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
        };
      }
    ]
  );
}
