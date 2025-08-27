import qs.io
import qs.components.bar
import Quickshell.Io
import QtQuick

BarModule {
  id: root
  required property var settings

  BarItem {
    text: {
      const lines = ColorPicker.color.trim().split("\n")
      const color = lines[lines.length - 1]

      return color
    }
  }
}
