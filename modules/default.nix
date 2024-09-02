{ pkgs, ... }:
let
  linux = [ ./linux ];
  darwin = [ ./darwin ];
in
{
  imports = [ ./common ] ++ (if pkgs.stdenv.isDarwin then darwin else linux);
}
