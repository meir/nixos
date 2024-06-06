{
  config,
  pkgs,
  lib,
  ...
}:
{
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
}
