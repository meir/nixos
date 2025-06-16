{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth support";
  };

  config = lib.mkIf config.modules.bluetooth.enable {
    environment.systemPackages = with pkgs; [
      python313Packages.ds4drv
      overskride
    ];

    services.udev.packages = with pkgs; [
      python313Packages.ds4drv
    ];

    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput", GROUP="input", MODE="0660"
    '';

    boot.kernelModules = [ "uinput" ];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      input.General.ClassicBondedOnly = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Privacy = "device";
          JustWorksRepairing = "always";
          Class = "0x000100";
          FastConnectable = true;
        };
      };
    };
  };
}
