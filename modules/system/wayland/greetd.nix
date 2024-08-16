{
  options,
  lib,
  config,
  pkgs,
  ...
}:
{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.gtkgreet;
  };
}
