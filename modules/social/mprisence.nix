{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    mprisence
  ];

  systemd.user.services."mprisence" = {
    Unit = {
      Description = "All in one Discord Rich Presence Music bridge";
    };
    Service = {
      ExecStart = "${pkgs.mprisence}/bin/mprisence";
      Type = "simple";
      Restart = "always";
      RestartSec = 10;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
