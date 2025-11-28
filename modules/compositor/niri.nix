{
  config,
  pkgs,
  lib,
  config_file ? null,
  ...
}:
with lib;
let
  startup = concatStringsSep "\n" (map (value: "spawn-at-startup \"${value}\"") config.protocol.autostart);
  binds = pkgs.izu.izuGenerate.override {
    formatter = "niri";
    hotkeys = config.protocol.hotkeys;
  };
  config_file_content = if config_file != null then builtins.readFile config_file else "";

  niriconfig = pkgs.writeScript "niri" ''
    binds {
    ${readFile binds}
    }
    ${startup}
    ${config_file_content}
  '';
in
{
  config = {
    programs.niri = {
      enable = true;
    };

    nix-fs.files.".config/niri/config.kdl" = {
      source = niriconfig;
    };

    environment.systemPackages = with pkgs; [ 
      alacritty
      xwayland-satellite # xwayland support
    ];

    security.polkit.enable = true;

    services.greetd = {
      enable = true;
      package = pkgs.unstable.greetd;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd 'niri-session'";
        };
      };
    };
  };
}
