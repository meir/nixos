# Based on https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/system/etc/etc.nix
{ config, pkgs, lib, ... }:
with lib;
let
  file' = filter (f: f.enable) (attrValues config.mine.file);
  file = pkgs.runCommandLocal "file" {
    passthru.targets = file';
  } ''
    set -euo pipefail

    makeHomeFile() {
      src="$1"
      target="$2"

      if [[ "$src" == *'*'* ]]; then
        mkdir -p "$out/$target"
        for f in $src; do
          ln -s "$f" "$out/$target/"
        done
      else
        mkdir -p "$out/$(dirname "$target")"
        if ! [ -e "$out/$target" ]; then
          ln -s "$src" "$out/$target"
        else
          echo "File $out/$target already exists, skipping"
          ret=1
        fi
      fi
    }

    mkdir -p "$out"
    ${
      concatStringsSep "\n" (
        f: escapeShellArgs [
          "makeHomeFile"
          "${f.source}"
          f.target
        ] file'
      )
    }
  '';
in {
  options = {
    mine.file = mkOption {
      default = {};
      description = "A map of files to be copied to the user's home directory.";
      example = ''
        { "example.txt" = ./example.txt; }
        { config = {
          enable = true;
          source = ./example.txt;
          target = "example.txt";
        }; }
      '';

      type = with types; attrsOf (submodule (
        { name, config, options, ... }:
        {
          options = {
            enable = mkOption {
              type = types.bool;
              default = true;
              description = "Whether to link this file to the user's home directory.";
            };

            target = mkOption {
              type = types.str;
              description = "Name of symlink (relative to home directory). Defaults to the attribute name.";
            };

            source = mkOption {
              type = types.path;
              description = "Path to the file to be linked.";
            };
          };

          config = {
            target = mkDefault name;
            source = (
              let name' = "home-" + lib.replaceStrings ["/"] ["-"] name;
              in mkDerivedConfig options.text (pkgs.writeText name')
            );
          };
        }
      ));
    };
  };

  system.build.homefiles = file;
  system.activationScripts.homedirectory =
    stringAfter [ "users" "groups" ] ''
      # TODO: add script that generates links in home directory
    '';
}
