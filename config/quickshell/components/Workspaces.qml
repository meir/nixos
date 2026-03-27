import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.data
import qs

RowLayout {
  spacing: 0
  property var screen

  readonly property var idle_color: Colors.background
  readonly property var active_color: Colors.color2
  readonly property var focused_color: Colors.color1

  Repeater {
    model: niri.workspaces

     Rectangle {
      visible: model.id < 11 && model.output == screen.name
      width: bar.height
      height: bar.height

      color: model.isFocused ? focused_color : model.activeWindowId != 0 ? active_color : idle_color

      Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        text: model.id
        color: Colors.foreground 
      }
      
      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: niri.focusWorkspaceByName(model.name)
      }
    }
  }
}
