import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
  Layout.fillHeight: true
  Layout.fillWidth: true
  default property alias data: content.data

  RowLayout {
    anchors.fill: parent
    spacing: 0

    Item { width: 10 }

    RowLayout {
      id: content
      spacing: 10
      Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    }  
  }
}
