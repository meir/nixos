import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.src.data
import qs

Rectangle {
  color: Colors.color1
  Layout.fillHeight: true 
  Layout.fillWidth: true
  Layout.maximumWidth: 300

  property string zscrollText: ""
  readonly property int max_length: 20
  property int zindex: 0

  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: zscroll() 
  }

  function zscroll() {
    var text = `${Music.title} - ${Music.artist}`
    zindex = (zindex + 1) % max_length
    zscrollText = text.length > max_length ? text.substring(zindex) + " | " + text.substring(0, zindex) : text
  }

  Text {
    id: title
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width - 40
    anchors.leftMargin: 20
    anchors.rightMargin: 20

    clip: true
    elide: Text.ElideRight
    wrapMode: Text.NoWrap

    text: "♫ " + zscrollText 
    color: Colors.foreground
    font.family: font_family
  }
}
