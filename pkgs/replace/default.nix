{ lib, stdenv }:

src: args:

stdenv.mkDerivation (
  {
    inherit src;
    name = if args ? name then args.name else baseNameOf (toString src);
    builder = builtins.toFile "builder.sh" ''
      source $stdenv/setup
      set -o pipefail

      eval "$preInstall"

      args=
      basedir=$(realpath $src)

      if [[ -d "$src" ]]; then
        pushd "$src"
        mkdir -p "$out"

        find $src -type f -print0 | while read -d "" line; do
          path=$(realpath "$line")
          path=''${path##$basedir}
          mkdir -p "$out$(dirname $path)"

          substituteAll "$line" "$out$path"
        
          if [[ -x "$line" ]]; then
            chmod +x "$out$path"
          fi
        done
        popd
      else
        substituteAll "$src" "$out"

        if [[ -x "$src" ]]; then
          chmod +x "$out"
        fi
      fi

      eval "$postInstall"
    '';
    preferLocalBuild = true;
    allowSubstitutes = false;
  }
  // args
)
