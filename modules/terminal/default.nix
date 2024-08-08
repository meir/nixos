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
in
recursiveUpdate
  {
    options.modules."${name}".config = mkOption {
      type = types.path;
      default = ./kitty.conf;
    };
  }
  (
    mkModule config "${name}" {
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

      programs.gnupg.agent = {
        enable = true;
      };

      environment.file.kitty = {
        source = configFile;
        target = ".config/kitty/kitty.conf";
      };

      sxhkd.keybind."super + Return" = "kitty";
    }
  )
