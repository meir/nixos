{
  config,
  pkgs,
  ...
}:
let
  grub = true;
in
{
  environment.systemPackages = with pkgs; [ comma ];

  programs.nh = {
    enable = true;
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

  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  boot.loader = {
    grub = {
      enable = grub;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;

      gfxmodeEfi = "1920x1080";
      gfxpayloadEfi = "keep";
      milk-theme.enable = true;
    };

    systemd-boot = {
      enable = !grub;
      consoleMode = "max";
      configurationLimit = 50;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.tmp.cleanOnBoot = true;
}
