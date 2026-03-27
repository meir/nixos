import Quickshell
import Quickshell.Io
import QtQuick
import qs.src.data
import qs.src.widgets.bar
import Niri

ShellRoot {
  readonly property string font: "DinaRemasterII Nerd Font"

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
}
