import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
  Layout.fillHeight: true
  Layout.fillWidth: true
  default property alias data: content.data

  RowLayout {
    spacing: 0
    Item { width: 20 }

    RowLayout {
      spacing: 10
      id: content
    }  
  }
}
