{ pkgs, ... }:
let
  compatTool = "GE-Proton10-28";
  vr_env = {
    PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES = 1;
    XRIZER_NO_PARALLEL_VIEWS = 1;
    OXR_PARALLEL_VIEWS = 1;
  };
in
{
  programs.steam.config = {
    enable = true;
    closeSteam = true;
    defaultCompatTool = compatTool;

    apps = {
      VRChat = {
        id = 438100;

        env = vr_env;

        args = [
          "-screen-width 640"
          "-screen-height 480"
        ];
      };
    };

    nonSteamApps = {
      vintage-story = {
        id = 8008135; # hehehe
        name = "Vintage Story";
        target = pkgs.unstable.vintagestory;
        inherit compatTool;
      };
      voices-of-the-void = {
        id = 2462834497;
        name = "Voices of the Void";
        target = "${pkgs.votv}/bin/VotV.exe";
        inherit compatTool;
      };
    };
  };
}
