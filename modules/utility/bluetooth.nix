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
      blueberry
      bluez
      bluez-alsa
      bluez-tools
    ];

    systemd.services.bluetooth = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
    };

    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          AutoEnable = true;
          ControllerMode = "bredr";
          Experimental = true;
        };
      };
      powerOnBoot = true;
    };
    services.blueman.enable = true;
    hardware.enableAllFirmware = true;

    boot.kernelModules = [
      "hid_playstation"
      "hid_generic"
      "hid"
    ];
  };
}
