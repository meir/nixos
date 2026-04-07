import Quickshell
import Quickshell.Io
import QtQuick
import qs.src.widgets
import Niri

ShellRoot { 
  id: root
  readonly property string font_family: "DinaRemasterII Nerd Font"
  readonly property int mainMonitor: 0
  readonly property string background_folder: "/home/human/Pictures/backgrounds/"

  Niri {
    id: niri
    Component.onCompleted: connect()

    onConnected: console.info("Connected to niri")
    onErrorOccurred: function(error) {
      console.error("Niri error:", error)
    }
  }

  Variants {
    model: Quickshell.screens;
    delegate: Bar {
      property var modelData;
    }
  }

  WallpaperPicker {}
}
