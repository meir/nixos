import Quickshell
import Quickshell.Io
import QtQuick
import qs.data
import qs.widgets.bar
import Niri

ShellRoot {
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
