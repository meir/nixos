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
    services.blueman.enable = true;
    hardware.enableAllFirmware = true;

    hardware.bluetooth = {
      enable = true;
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
      powerOnBoot = true;
    };
  };
}
