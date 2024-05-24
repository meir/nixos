{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.kitty.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.kitty.enable {
    modules.packages = with pkgs; [ kitty ];

    environment.file.kitty = {
      source = ./kitty.conf;
      target = ".config/kitty/kitty.conf";
    };
  };
}
