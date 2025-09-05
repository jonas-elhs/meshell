pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property var settings
  property string color
  property string colorType
  property bool copy: false
  property string previewColor: {
    const parts = root.color.split(" ")

    switch (settings?.colorPickerColorType ?? "") {
      case "hex": {
        return root.color
      }
      case "rgb": {
        const percentages = parts.map(color => parseInt(color) / 255)

        return Qt.rgba(percentages[0], percentages[1], percentages[2], 1)
      }
      case "hsl": {
        const hue = parseInt(parts[0]) / 360
        const saturation = parseInt(parts[1].substring(0, 3)) / 100
        const lightness = parseInt(parts[2].substring(0, 3)) / 100

        return Qt.hsla(hue, saturation, lightness, 1)
      }
      case "hsv": {
        const hue = parseInt(parts[0]) / 360
        const saturation = parseInt(parts[1].substring(0, 3)) / 100
        const value = parseInt(parts[2].substring(0, 3)) / 100

        return Qt.hsva(hue, saturation, value, 1)
      }
      default: {
        return root.color
      }
    }
  }
  property list<string> formattedColor: {
    const split = root.color.split(" ")

    switch (settings?.colorPickerColorType ?? "") {
      case "hex": {
        const value = color.slice(1)

        return [ value.slice(0, 2), value.slice(2, 4), value.slice(4, 6) ]
      }
      case "rgb":
      case "hsl":
      case "hsv": {
        return split
      }
      default: {
        return color
      }
    }
  }

  function pickColor(colorType: string, settings: var, copy: bool) {
    root.settings = settings
    root.colorType = colorType
    root.copy = copy ?? false
    picker.running = true
  }

  Process {
    id: picker

    command: [ "hyprpicker", "--no-fancy", root.copy ? "--autocopy" : "", "--format", root.colorType ]
    stdout: StdioCollector {
      onStreamFinished: {
        root.color = this.text.trim().split("\n").filter((line) => !line.startsWith("["))[0]?.trim() ?? null

        if (root.copy) {
          console.log("copy")
        }
        if (root.color) {
          settings.colorPickerColorType = root.colorType
          settings.barCenterWidget = ""
          settings.barCenterWidget = "colorPicker"
        }
      }
    }
  }
}
