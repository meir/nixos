import Quickshell
import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
  anchors.fill: parent 
  default property alias data: content.data

  RowLayout {
    id: content
    anchors.fill: parent
    spacing: 0
  }
}
