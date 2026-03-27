import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import qs

Scope {
  id: wallpaperPicker

  property bool active: false

  IpcHandler {
    target: "WallpaperPicker"

    function open() {
      get_wallpaper_paths()
      wallpaperPicker.active = true
    }
  }

  // ----- Load wallpapers -----
  ListModel {
    id: wallpaperModel
  }

  function get_wallpaper_paths() {
    wallpaperModel.clear()
    wallpaperScanner.running = true
  }

  Process {
    id: wallpaperScanner
    command: [
      "find",
      background_folder,
      "-type", "f",
      "-iname", "*.jpg",
      "-o", "-iname", "*.jpeg",
      "-o", "-iname", "*.png",
      "-o", "-iname", "*.webp",
    ]
    running: true
    stdout: StdioCollector {
      onStreamFinished: function() {
        for (var line of this.text.split("\n")) {
          if (line.trim() !== "") {
            wallpaperModel.append({ path: line.trim() })
          }
        }
        wallpaperScanner.running = false
        console.info("Found " + wallpaperModel.count + " wallpapers")
      }
    }
  }

  // ----- Set wallpaper -----
  
  function set_wallpaper(path) {
    Qt.callLater(() => {
      Quickshell.execDetached([
        "swww", "img", path,
        "--transition-type", "grow",
      ])

      Quickshell.execDetached([
        "cwal", "--img", path,
      ])
            
      Quickshell.execDetached([
        "notify-send", "Wallpaper Changed", 
        path.split('/').pop()
      ])
            
      wallpaperPicker.active = false
    })
  }

  // ----- UI -----

  PanelWindow {
    id: pickerWindow
    screen: Quickshell.screens[mainMonitor]
    focusable: true

    anchors {
      top: true
      bottom: true
      left: true
      right: true
    }

    margins {
      top:0
      bottom:0
      left:0
      right:0
    }

    visible: wallpaperPicker.active
    color: "transparent"

    Rectangle {
      id: cardContainer
      width: Quickshell.screens[mainMonitor].width
      height: 800
      anchors.centerIn: parent
      color: "transparent" 
      clip: true
      focus: true

      Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Escape) {
          wallpaperPicker.active = false
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          parent.forceActiveFocus()
        }
      }
      
      GridView {
        id: gridView
        model: wallpaperModel
        anchors.fill: parent
        cellWidth: 250
        cellHeight: parent.height
        clip: false
        flow: GridView.FlowTopToBottom
        keyNavigationEnabled: true

        delegate: Rectangle {
          width: gridView.cellWidth
          height: gridView.cellHeight
          color: "transparent"
          anchors.margins: 10

          Image {
            id: thumbnail
            anchors.fill: parent
            anchors.margins:10

            source: "file://" + model.path
            fillMode: Image.PreserveAspectCrop
            smooth: true
            cache: true
            asynchronous: true
            sourceSize.width: gridview.cellWidth
            sourceSize.height: gridview.cellHeight

            onStatusChanged: {
              if (status === Image.Error) {
                console.error("Failed to load image:", model.path)
              }
            }
            visible: false // hidden, the image will be rendered by the mask
          }

          MultiEffect {
            source: thumbnail
            anchors.fill: thumbnail 
            maskEnabled: true
            maskSource: mask
          }

          Item {
            id: mask
            width: thumbnail.width
            height: thumbnail.height
            layer.enabled: true
            visible: false

            Rectangle {
              width: thumbnail.width
              height: thumbnail.height
              radius: width/2
              color: "black"
            }
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              set_wallpaper(model.path)
            }
          }
        }
      }
    }
  }
}
