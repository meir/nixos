{ lib, stdenv }:

src: args:

stdenv.mkDerivation (
  {
    inherit src;
    name = if args ? name then args.name else baseNameOf (toString args.src);
    builder = builtins.toFile "builder.sh" ''
      source $stdenv/setup
      set -o pipefail

      eval "$preInstall"

      args=
      basedir=$(dirname $(realpath $args.src))

      if [[ -d "args.src" ]]; then
        xargs -0 -n1 -I args.src -- find {} -type f -print0 | while read -d "" line; do
          path=${$(realpath $line)##$basedir}
          mkdir -p "$out/$(dirname "$path")"
          substituteAll "$line" "$out/$path"
        
          if [[ -x "$line" ]]; then
            chmod +x "$out/$path"
          fi
        done
      else
        path=${$(realpath $line)##$args.src}
        mkdir -p "$out/$(dirname "$path")"
        substituteAll "$line" "$out/$path"

        if [[ -x "$args.src" ]]; then
          chmod +x "$out/$path"
        fi
      fi

      eval "$postInstall"
    '';
    preferLocalBuild = true;
    allowSubstitutes = false;
  }
  // args
)
