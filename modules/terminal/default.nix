{
  config,
  pkgs,
  mkModule,
  lib,
  ...
}:
with lib;
let
  name = "kitty";

  configFile = pkgs.writeScript "kitty-config" ''
    ${readFile ./kitty.conf}

    ${readFile config.modules."${name}".config}
  '';

  wayland = config.protocol.wayland.enable;
in
mkModule config "${name}" {
  options.modules."${name}".config = mkOption {
    type = types.path;
    default = ./kitty.conf;
  };

  config = {
    environment.packages = with pkgs; [
      kitty

      # terminal tools
      btop
      nvtopPackages.full
      fastfetch
      xdotool
      cargo
      rustc
    ];

    protocol.rules = mkIf wayland [ "set $term kitty" ];

    programs.gnupg.agent = {
      enable = true;
    };

    environment.file.kitty = {
      source = configFile;
      target = ".config/kitty/kitty.conf";
    };

    protocol.hotkeys."super + Return" = "kitty";
  };
}
