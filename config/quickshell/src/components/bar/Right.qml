import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Item {
  Layout.fillHeight: true
  Layout.fillWidth: true
  default property alias data: content.data

  RowLayout {
    anchors.fill: parent
    spacing: 0

    RowLayout {
      id: content
      spacing: 10
      Layout.alignment: Qt.AlignRight
    }
    
    Item { width: 20 }
  }
}
