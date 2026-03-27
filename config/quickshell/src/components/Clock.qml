import Quickshell
import QtQuick
import qs.src.data
import qs

Rectangle {
  implicitHeight: clock.implicitHeight
  implicitWidth: clock.implicitWidth
  color: Colors.background

  Text {
    id: clock
    text: Time.fmt("yyyy-MM-dd HH:mm:ss")
    color: Colors.foreground
    font.family: font
  }
}
