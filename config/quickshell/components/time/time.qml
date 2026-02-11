import QtQuick

Text {
  id: clock
  anchors.centerIn: parent

  Process {
    id: dateProcess
    command: ["date"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: clock.text = this.text
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProcess.running = true
  }
}
