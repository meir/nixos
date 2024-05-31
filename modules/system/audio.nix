{ config, options, pkgs, lib, ... }:
with lib; {

  environment.packages = with pkgs; [ alsa-utils libdrm pavucontrol ];

  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}

