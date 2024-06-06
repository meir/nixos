# https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/system/etc/etc.nix
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let

  homefiles' = filter (f: f.enable) (attrValues config.environment.file);

  homefiles =
    pkgs.runCommandLocal "homefiles"
      {
        # This is needed for the systemd module
        passthru.targets = map (x: x.target) homefiles';
      }
      # sh
      ''
        set -euo pipefail

        makehomeEntry() {
          src="$1"
          target="$2"

          if [[ "$src" = *'*'* ]]; then
            # If the source name contains '*', perform globbing.
            mkdir -p "$out/home/$target"
            for fn in $src; do
                ln -s "$fn" "$out/home/$target/"
            done
          else

            mkdir -p "$out/home/$(dirname "$target")"
            if ! [ -e "$out/home/$target" ]; then
              ln -s "$src" "$out/home/$target"
            else
              echo "duplicate entry $target -> $src"
              if [ "$(readlink "$out/home/$target")" != "$src" ]; then
                echo "mismatched duplicate entry $(readlink "$out/home/$target") <-> $src"
                ret=1

                continue
              fi
            fi
          fi
        }

        mkdir -p "$out/home"
        ${concatMapStringsSep "\n" (
          homeEntry:
          escapeShellArgs [
            "makehomeEntry"
            # Force local source paths to be added to the store
            "${homeEntry.source}"
            homeEntry.target
          ]
        ) homefiles'}
      '';
in
{
  options = {

    environment.file = mkOption {
      default = { };
      example = literalExpression ''
        { example-configuration-file =
            { source = "/nix/store/.../home/dir/file.conf.example";
              mode = "0440";
            };
          "default/useradd".text = "GROUP=100 ...";
        }
      '';
      description = lib.mdDoc ''
        Set of files that have to be linked in {file}`/home`.
      '';

      type =
        with types;
        attrsOf (
          submodule (
            {
              name,
              config,
              options,
              ...
            }:
            {
              options = {

                enable = mkOption {
                  type = types.bool;
                  default = true;
                  description = lib.mdDoc ''
                    Whether this /home file should be generated.  This
                    option allows specific /home files to be disabled.
                  '';
                };

                target = mkOption {
                  type = types.str;
                  description = lib.mdDoc ''
                    Name of symlink (relative to
                    {file}`/home`).  Defaults to the attribute
                    name.
                  '';
                };

                text = mkOption {
                  default = null;
                  type = types.nullOr types.lines;
                  description = lib.mdDoc "Text of the file.";
                };

                source = mkOption {
                  type = types.path;
                  description = lib.mdDoc "Path of the source file.";
                };
              };

              config = {
                target = mkDefault name;
                source = mkIf (config.text != null) (
                  let
                    name' = "home-" + lib.replaceStrings [ "/" ] [ "-" ] name;
                  in
                  mkDerivedConfig options.text (pkgs.writeText name')
                );
              };
            }
          )
        );
    };
  };

  ###### implementation

  config = {

    system.build.home = homefiles;
    system.activationScripts.home =
      stringAfter
        [
          "users"
          "groups"
        ]
        ''
          # Set up the statically computed bits of /home.
          echo "setting up ${config.user_home}..."
          ${
            pkgs.perl.withPackages (p: [ p.FileSlurp ])
          }/bin/perl ${./setup-home.pl} ${homefiles}/home ${config.user_home}
        '';
  };
}
