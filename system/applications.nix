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
    Categories=${concatStringsSep ";" (toList entry.categories)}
  '';

  desktopEntryPath = key: ".local/share/applications/${key}.desktop";

  files = builtins.foldl' (
    acc: entryKey:
    let
      entry = config.desktop.entry.${entryKey};
    in
    acc
    // {
      "${desktopEntryPath entryKey}" = {
        text = desktopEntryContent entry;
      };
    }
  ) { } (builtins.attrNames config.desktop.entry);
in
{
  options.desktop.entry = mkOption {
    default = {};
    type = types.attrsOf (
      types.submodule {
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
      }
    );
  };

  config = {
    nix-fs.files = files;
  };
}
