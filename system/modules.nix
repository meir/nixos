{ config, lib, ... }:
with lib;
{
  options.protocol.modules = mkOption {
    type = types.listOf types.submodule;
    default = [];
    description = "Enable custom modules.";
  };

  imports = config.protocol.modules;
}
