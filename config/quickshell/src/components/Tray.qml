import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.src.data
import qs

Repeater {
  model: SystemTray.items

  delegate: Item {
    required property SystemTrayItem modelData
    width: 16
    height: 16

    Image {
      anchors.centerIn: parent
      source: parent.modelData.icon
      width: 16
      height: 16
      smooth: true
      mipmap: true
    }

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onEntered: parent.opacity = 0.8
      onExited: parent.opacity = 1.0
      onClicked: event => {
        if (event.button === Qt.LeftButton)
          parent.modelData.secondaryActivate()
        else
          parent.modelData.secondaryActivate()
      }
    }

    Behavior on opacity { NumberAnimation { duration: 150 } }
  }
}
