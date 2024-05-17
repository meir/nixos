{ config, pkgs, lib, ... }:
let
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
in {
  environment.defaultPackages = with pkgs; [
    git
    curl
  ];

  users.users."${config.user}" = {
    isNormalUser = true;
    home = config.user_home;
    initialPassword = "nixos";
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "desktop"
    ];
  };
  
  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ config.user ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  boot.tmp.cleanOnBoot = true;

  time.timeZone = timezone;
  i18n = {
    defaultLocale = locale;
    extraLocaleSettings = {
      LANGUAGE = locale;
      LC_ALL = locale;
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 ];
      allowedUDPPorts = [ 443 80 ];
      allowPing = false;
    };
  };

  security = {
    sudo.enable = true;
    doas = {
      enable = true;
      extraRules = [{
        users = [ config.user ];
        keepEnv = true;
        persist = true;
      }];
    };

    protectKernelImage = true;
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  }; 

  system.stateVersion = "23.11";
}
