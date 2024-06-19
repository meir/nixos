{ config, options, pkgs, lib, ... }:
{
  boot.loader = {
    systemd = {
      enable = true;
      consoleMode = "max";
      configurationLimit = 50;
    };
    efi.canTouchEfiVariables = true;
  };
}
