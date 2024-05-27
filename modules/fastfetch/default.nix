{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.fastfetch.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.fastfetch.enable {
    modules.packages = with pkgs; [ fastfetch ];

    environment.file.fastfetch = {
      source = ./config.jsonc;
      target = ".config/fastfetch/config.jsonc";
    };
  };
}
