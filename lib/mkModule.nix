{ lib, ... }:
config: name: cfg: with lib; {
  options.modules."${name}".enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf config.modules."${name}".enable cfg;
}
