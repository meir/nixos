{ 
  pkgs,
  lib,
  cwal_config ? null,
  cwal_templates ? null,
  ...
}:
with lib;
{
  environment.systemPackages = with pkgs; [
    quickshell
    jq
    zscroll
    cwal
  ];

  nix-fs.files.".config/cwal/templates".source = mkIf (cwal_templates != null) cwal_templates;
  nix-fs.files.".config/cwal/cwal.ini".source = mkIf (cwal_config != null) cwal_config;
}
