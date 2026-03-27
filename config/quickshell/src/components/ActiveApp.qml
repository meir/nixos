import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.src.data
import qs

Rectangle {
  Layout.fillHeight: true 
  Layout.fillWidth: true
  color: "transparent"

  Text {
    anchors.centerIn: parent
    text: niri.focusedWindow?.title ?? "-"
    color: "white"
    font.family: font
    font.underline: true
  }
}
