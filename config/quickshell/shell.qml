import Quickshell
import Quickshell.Io
import QtQuick
import qs.data
import qs.widgets.bar

Variants {
  model: Quickshell.screens;
  delegate: Bar {
    property var modelData;
  }
}
