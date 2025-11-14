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
    browser = mkOption {
      type = types.enum [
        "zenbrowser"
        "qutebrowser"
      ];
      default = "zenbrowser";
      description = ''
        Choose a web browser to install and configure.
        Options are "zenbrowser" (default) or "qutebrowser".
      '';
    };
  };

  config = (
    mkMerge [
      (mkIf config.modules.discord.enable {
        environment.systemPackages = with pkgs; [
          discord
        ];

        security.polkit.enable = true;
        boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

        programs.droidcam.enable = true;
      })

      (mkIf (config.modules.browser == "zenbrowser") {
        environment.systemPackages = with pkgs; [
          zen-browser.default
        ];

        xdg.mime.defaultApplications = {
          "text/html" = "zenbrowser.desktop";
          "x-scheme-handler/http" = "zenbrowser.desktop";
          "x-scheme-handler/https" = "zenbrowser.desktop";
        };
      })

      (mkIf (config.modules.browser == "qutebrowser") {
        environment.systemPackages = with pkgs; [
          qutebrowser
          jq
        ];

        files.".config/qutebrowser/config.py".source = ../config/qutebrowser/config.py;

        xdg.mime.defaultApplications = {
          "text/html" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
        };
      })
    ]
  );
}
