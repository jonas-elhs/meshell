pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property var settings
  property string color
  property string colorType

  function pickColor(colorType: string, settings: var) {
    root.settings = settings
    root.colorType = colorType
    picker.running = true
  }
  function getColorParts(): list<string> {
    const split = root.color.split(" ")

    switch (settings?.colorPickerColorType ?? "") {
      case "hex":
       const value = color.slice(1)
       return [ value.slice(0, 2), value.slice(2, 4), value.slice(4, 6) ]
      case "rgb":
      case "hsl":
      case "hsv":
        return split
      default:
       return color
    }
  }

  Process {
    id: picker

    command: [ "hyprpicker", "--no-fancy", "--format", root.colorType ]
    stdout: StdioCollector {
      onStreamFinished: {
        root.color = this.text.trim().split("\n").filter((line) => !line.startsWith("["))[0]?.trim() ?? null

        if (root.color) {
          settings.colorPickerColorType = root.colorType
          settings.barCenterWidget = ""
          settings.barCenterWidget = "colorPicker"
        }
      }
    }
  }
}
