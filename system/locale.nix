{
  config,
  pkgs,
  lib,
  ...
}:
let
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
in
{
  time.timeZone = timezone;

  # environment.systemPackages = with pkgs; [ anthy ];

  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LANGUAGE = locale;
      LC_ALL = locale;
    };

    # inputMethod = {
    #   type = "ibus";
    #   enable = true;
    #   ibus = {
    #     engines = with pkgs.ibus-engines; [ anthy ];
    #   };
    # };
  };

  environment.variables = {
    IBUS_ENABLE_SYNC_MODE = "1";
    GLFW_IM_MODULE = "ibus";
  };

  # protocol.autostart = [ "ibus-daemon -drx" ];
}
