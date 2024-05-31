{ pkgs, ... }: {
  imports = [ ../../modules ];

  config = { user = "human"; };
}
