{ config, ... }:
{
  system.defaults = {
    dock = {
      # who even needs a dock?
      autohide = true;
      autohide-delay = 1000;
      launchanim = false;
      minimize-to-application = false;
    };
    screencapture = {
      type = "png";
      location = "~/Pictures/screenshots";
      show-thumbnail = false;
      disable-shadow = false;
    };
    trackpad = {
      Clicking = true;
      Dragging = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 0;
      ActuationStrength = 1;
      FirstClickThreshold = 0;
      SecondClickThreshold = 0;
    };
    smb = {
      ServerDescription = "${config.user}";
      NetBIOSName = "${config.user}";
    };
    alf = {
      loggingenabled = 1;
      stealthenabled = 1;
      allowsignedenabled = 1;
      allowdownloadsignedenabled = 1;
      globalstate = 1;
    };
    loginwindow = {
      LoginwindowText = "";
      SHOWFULLNAME = true;
      GuestEnabled = false;
      DisableConsoleAccess = true;
      autoLoginUser = "${config.user}";
    };
    universalaccess = {
      reduceMotion = true;
      reduceTransparency = true;
      mouseDriverCursorSize = 1;
    };
    finder = {
      ShowPathbar = true;
      CreateDesktop = false;
      QuitMenuItem = true;
      ShowStatusBar = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXPreferredViewStyle = "Nlsv";
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
    };
    WindowManager = {
      GloballyEnabled = false;
      StandardHideDesktopIcons = true;
    };
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 5;
    };
    spaces = {
      spans-displays = false;
    };
  };
}
