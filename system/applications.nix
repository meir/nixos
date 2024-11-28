{ config, lib, ... }:
with lib;
let
  desktopEntryContent = entry: ''
    [Desktop Entry]
    Name=${entry.name}
    Comment=${entry.comment}
    Exec=${entry.exec}
    Icon=${entry.icon}
    Terminal=${toString entry.terminal}
    Type=${entry.type}
    Categories=${concatStringsSep ";" entry.categories}
  '';

  desktopEntryPath = key: "${config.home.homeDirectory}/.local/share/applications/${key}.desktop";

  files = builtins.foldl' (key: entry: acc: {
    "${(desktopEntryPath "${key}")}" = {
      text = desktopEntryContent entry;
    };
  }) { } config.desktop.entry;
in
{
  options.desktop.entry = {
    type = types.attrsOf (submodule {
      options = {
        name = mkOption {
          type = types.str;
          default = "";
          description = "Name of the entry";
        };
        comment = mkOption {
          type = types.str;
          default = "";
          description = "Comment of the entry";
        };
        exec = mkOption {
          type = types.str;
          default = "";
          description = "Command to run";
        };
        icon = mkOption {
          type = types.str;
          default = "";
          description = "Icon of the entry";
        };
        terminal = mkOption {
          type = types.bool;
          default = false;
          description = "Run in terminal";
        };
        type = mkOption {
          type = types.str;
          default = "Application";
          description = "Type of the entry";
        };
        categories = mkOption {
          type = types.listOf types.str;
          default = [ "Utility" ];
          description = "Categories of the entry";
        };
      };
    });
  };

  config = {
    hm.home.file = files;
  };
}
