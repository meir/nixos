{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zen-browser.default
  ];

  xdg.mime.defaultApplications = {
    "text/html" = "zenbrowser.desktop";
    "x-scheme-handler/http" = "zenbrowser.desktop";
    "x-scheme-handler/https" = "zenbrowser.desktop";
  };
}
