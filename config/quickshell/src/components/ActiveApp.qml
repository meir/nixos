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
    horizontalAlignment: Text.AlignHCenter
    width: parent.width - 40
    text: niri.focusedWindow?.title ?? "-"
    
    clip: true
    elide: Text.ElideRight
    wrapMode: Text.NoWrap

    color: "white"

    font.family: font_family
    font.underline: true
  }
}
