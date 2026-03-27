import Quickshell
import QtQuick
import qs.data
import qs

Rectangle {
  color: Colors.color1

  Text {
    text: Music.title + " - " + Music.artist
    color: Colors.foreground
    font {
      family: Config.font
    }
  }
}
