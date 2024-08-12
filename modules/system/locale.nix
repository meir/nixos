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

  environment.packages = with pkgs; [ anthy ];

  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LANGUAGE = locale;
      LC_ALL = locale;
    };

    inputMethod = {
      enabled = "ibus";
      ibus = {
        engines = with pkgs.ibus-engines; [ anthy ];
      };
    };
  };

  environment.variables = {
    IBUS_ENABLE_SYNC_MODE = "1";
    GLFW_IM_MODULE = "ibus";
  };
}
