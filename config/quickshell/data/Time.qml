pragma Singleton
import Quickshell
import QtQuick

Singleton {
  id: root

  property string time: clock.date
  readonly property SystemClock clock: clock

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  function fmt(fmt) {
    return Qt.formatDateTime(clock.date, fmt)
  }
}
