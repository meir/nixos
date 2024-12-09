{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = pkgs.writeScript "config" (concatStringsSep "\n\n" config.protocol.hotkeys);
  generate = runCommand "izu" { buildInputs = [ pkgs.izu ]; } ''
    izu --config ${cfg} --formatter ${config.system.izu.formatter} > $out
  '';
in
{
  options.system.izu = {
    formatter = mkOption {
      type = types.str;
      default = "sxhkd";
    };
    hotkeys = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = {
    system.izu.hotkeys = "${generate}";
  };
}
