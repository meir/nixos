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

  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LANGUAGE = locale;
      LC_ALL = locale;
    };
  };
}
