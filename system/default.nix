{ pkgs, ... }:
{
  imports = [ (if pkgs.stdenv.isDarwin then ./darwin else ./linux) ];
}
