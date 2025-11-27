{
  config,
  pkgs,
  lib,
  config_file ? null,
  ...
}:
with lib;
let
  startup = concatStringsSep "\n" (map (value: "exec-once = ${value}") config.protocol.autostart);
  rules = concatStringsSep "\n\n" config.protocol.rules;
  binds = pkgs.izu.izuGenerate.override {
    formatter = "hyprland";
    hotkeys = config.protocol.hotkeys;
  };
  config_file_content = if config_file != null then builtins.readFile config_file else "";

  hyprconfig = pkgs.writeScript "hyprland" ''
    ${readFile binds}
    ${rules}
    ${startup}
    ${config_file_content}
  '';
in
{
  config = {
    environment.systemPackages = with pkgs; [
      socat
      wl-clipboard
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    nix-fs.files.".config/hypr/hyprland.conf" = {
      source = hyprconfig;
    };

    security.polkit.enable = true;

    services.greetd = {
      enabled = true;
      package = pkgs.unstable.greetd;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd 'dbus-run-sesion Hyprland'";
        };
      };
    };
  };
}
