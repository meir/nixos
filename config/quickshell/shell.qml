import Quickshell
import Quickshell.Io
import QtQuick
import qs.data

Variants {
  model: Quickshell.screens;

  delegate: Component {
    PanelWindow {
      required property var modelData

      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      Text {
        text: Music.title + " - " + Music.artist
      }
    }
  }
}
