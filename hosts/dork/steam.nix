{ pkgs, lib, ... }:
let
  compatTool = "GE-Proton10-32";
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
        launchOptions = {
          env = vr_env;

          args = [
            "-screen-width 640"
            "-screen-height 480"
          ];
        };
      };
      RDR2 = {
        id = 1174180;
        launchOptions = {
          env = {
            MANGOHUD = 1;
          };
          
          wrappers = [
            (lib.getExe pkgs.gamemode)
          ];
        };
        inherit compatTool;
      };
    };

    nonSteamApps = {
      vintage-story = {
        name = "Vintage Story";
        target = pkgs.unstable.vintagestory;
      };
      voices-of-the-void = {
        name = "Voices of the Void";
        target = "${pkgs.votv}/bin/VotV.exe";
        launchOptions = {
          env = {
            WINE_DO_NOT_CREATE_DXGI_DEVICE_MANAGER = 1;
          };
        };
        inherit compatTool;
      };
    };
  };
}
