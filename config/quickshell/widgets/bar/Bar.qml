import Quickshell
import Quickshell.Io
import QtQuick
import qs.data

Item {
  PanelWindow {
    screen: modelData

    color: Colors.background

    anchors {
      top: true
      left: true
      right: true
    }

    margins {
      left: 10
      right: 10
      top: 10
    }

    implicitHeight: 30

    Text {
      text: Music.title + " - " + Music.artist
      color: Colors.foreground
    }

    Text {
      text: Time.fmt("yyyy-MM-dd HH:mm:ss")
      color: Colors.foreground
    }
  }
}
