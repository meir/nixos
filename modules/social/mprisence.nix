{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    mprisence
  ];

  systemd.user.services."mprisence" = {
    enable = true;
    serviceConfig = {
      ExecStart = "${pkgs.mprisence}/bin/mprisence";
      Type = "simple";
      Restart = "always";
      RestartSec = 10;
    };
    after = [ "default.target" ];
  };
}
