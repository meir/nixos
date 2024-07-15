{
  lib,
  options,
  config,
  pkgs,
  mkModule,
  ...
}:
let
  name = "dunst";
in
{
  options.modules."${name}".source = lib.mkOption {
    type = lib.types.path;
    default = null;
  };
}
// mkModule config "${name}" {
  environment.packages = with pkgs; [ dunst ];

  environment.file.dunst = lib.mkIf config.modules."${name}".source {
    source = config.modules."${name}".source;
    target = ".config/dunst/dunstrc";
  };
}
