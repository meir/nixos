import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs
import qs.data
import qs.components
import qs.components.bar

Item {
  PanelWindow {
    id: bar
    screen: modelData

    anchors {
      top: true
      left: true
      right: true
    }

    margins {
      left: 200
      right: 200
      top: 10
    }

    implicitHeight: 50
    color: "transparent"

    Bar {
      color: Colors.background 
      radius: 5

      Left {
        Workspaces {
          screen: bar.screen
        }
      }

      Center {
        ActiveApp{}
      }

      Right {
        Media{}
        Clock{}
      }
    }
  }
}
