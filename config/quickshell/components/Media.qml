import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.data
import qs

Rectangle {
  implicitWidth: 300
  color: Colors.color1
  Layout.fillHeight: true 

  Text {
    id: title
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 20
    anchors.rightMargin: 20

    elide: Text.ElideRight
    wrapMode: Text.NoWrap

    text: Music.title + " - " + Music.artist
    color: Colors.foreground
    font {
      family: Config.font
    }
  }
}
