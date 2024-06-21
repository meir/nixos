{
  config,
  options,
  pkgs,
  lib,
  ...
}:
{
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
      configurationLimit = 50;
    };
    grub.enable = false;
    efi.canTouchEfiVariables = true;
  };
}
