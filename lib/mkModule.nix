{ lib, ... }:
name: cfg: {
  options.modules."${name}".enable = lib.mkOption {
    type = types.bool;
    default = false;
  };

  config = lib.mkIf config.modules."${name}".enable cfg;
}
