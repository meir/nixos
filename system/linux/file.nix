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

  perlScript = pkgs.writeScript "userfiles" ''
    # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/system/etc/setup-etc.pl
    use strict;
    use File::Find;
    use File::Copy;
    use File::Path;
    use File::Basename;
    use File::Slurp;

    my $store = $ARGV[0] or die;
    my $home = $ARGV[1] or die;
    my $static = "$home/static";

    sub atomicSymlink {
        my ($source, $target) = @_;
        my $tmp = "$target.tmp";
        unlink $tmp;
        symlink $source, $tmp or return 0;
        if (rename $tmp, $target) {
            return 1;
        } else {
            unlink $tmp;
            return 0;
        }
    }


    # Atomically update $HOME/static to point at the home files of the
    # current configuration.
    atomicSymlink $store, $static or die;

    # Returns 1 if the argument points to the files in $HOME/static.  That
    # means either argument is a symlink to a file in $HOME/static or a
    # directory with all children being static.
    sub isStatic {
        my $path = shift;

        if (-l $path) {
            my $target = readlink $path;
            return substr($target, 0, length "$home/static/") eq "$home/static/";
        }

        if (-d $path) {
            opendir DIR, "$path" or return 0;
            my @names = readdir DIR or die;
            closedir DIR;

            foreach my $name (@names) {
                next if $name eq "." || $name eq "..";
                unless (isStatic("$path/$name")) {
                    return 0;
                }
            }
            return 1;
        }

        return 0;
    }

    # Remove dangling symlinks that point to $HOME/static.  These are
    # configuration files that existed in a previous configuration but not
    # in the current one.
    sub cleanup {
        if ($File::Find::name eq "$home/.nixos-profile") {
            $File::Find::prune = 1;
            return;
        }
        if (-l $_) {
            my $target = readlink $_;
            if (substr($target, 0, length $static) eq $static) {
                my $x = "$home/static/" . substr($File::Find::name, length "$home/");
                unless (-l $x) {
                    print STDERR "removing obsolete symlink ‘$File::Find::name’...\n";
                    unlink "$_";
                }
            }
        }
    }

    find(\&cleanup, "$home");


    # Use $HOME/.clean to keep track of copied files.
    my @oldCopied = read_file("$home/.clean", chomp => 1, err_mode => 'quiet');
    open CLEAN, ">>$home/.clean";


    # For every file in the etc tree, create a corresponding symlink in
    # /etc to $HOME/static.  The indirection through $HOME/static is to make
    # switching to a new configuration somewhat more atomic.
    my %created;
    my @copied;

    sub link {
        my $fn = substr $File::Find::name, length($store) + 1 or next;

        my $target = "$home/$fn";
        File::Path::make_path(dirname $target);
        $created{$fn} = 1;

        # Rename doesn't work if target is directory.
        if (-l $_ && -d $target) {
            if (isStatic $target) {
                rmtree $target or warn;
            } else {
                warn "$target directory contains user files. Symlinking may fail.";
            }
        }

        if (-e "$_.mode") {
            my $mode = read_file("$_.mode"); chomp $mode;
            if ($mode eq "direct-symlink") {
                atomicSymlink readlink("$static/$fn"), $target or warn "could not create symlink $target";
            } else {
                my $uid = read_file("$_.uid"); chomp $uid;
                my $gid = read_file("$_.gid"); chomp $gid;
                copy "$static/$fn", "$target.tmp" or warn;
                $uid = getpwnam $uid unless $uid =~ /^\+/;
                $gid = getgrnam $gid unless $gid =~ /^\+/;
                chown int($uid), int($gid), "$target.tmp" or warn;
                chmod oct($mode), "$target.tmp" or warn;
                unless (rename "$target.tmp", $target) {
                    warn "could not create target $target";
                    unlink "$target.tmp";
                }
            }
            push @copied, $fn;
            print CLEAN "$fn\n";
        } elsif (-l "$_") {
            atomicSymlink "$static/$fn", $target or warn "could not create symlink $target";
        }
    }

    find(\&link, $store);


    # Delete files that were copied in a previous version but not in the
    # current.
    foreach my $fn (@oldCopied) {
        if (!defined $created{$fn}) {
            $fn = "/etc/$fn";
            print STDERR "removing obsolete file ‘$fn’...\n";
            unlink "$fn";
        }
    }


    # Rewrite $HOME/.clean.
    close CLEAN;
    write_file("$home/.clean", map { "$_\n" } sort @copied);

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
          }/bin/perl ${perlScript} ${homefiles}/home ${config.user_home}
        '';
  };
}
