import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Item {
  Layout.fillHeight: true
  Layout.fillWidth: true

  RowLayout {
    Layout.alignment: Qt.AlignRight
    spacing: 0
    RowLayout {
      spacing: 10
      id: content
    }
    
    Item { width: 20 }
  }
}
