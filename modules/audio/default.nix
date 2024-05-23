{ config, options, pkgs, lib, ... }:
with lib; {

  modules.packages = [ alsa-utils ];

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

