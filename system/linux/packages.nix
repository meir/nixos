{ config, lib, ... }:
with lib;
{
  options.environment.packages = mkOption { type = types.listOf types.package; };

  config = {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = config.environment.packages;
  };
}
