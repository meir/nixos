import Quickshell
import QtQuick
import qs.data
import qs

Rectangle {
  Text {
    text: Time.fmt("yyyy-MM-dd HH:mm:ss")
    color: Colors.foreground
    font {
      family: Config.font
    }
  }
}
