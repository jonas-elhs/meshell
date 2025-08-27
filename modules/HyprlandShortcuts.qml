import qs.io
import Quickshell.Hyprland
import Quickshell
import QtQuick

Scope {
  id: root

  // Bar
  SettingsShortcut {
    name: "bar"
    description: "Toggle the bar"

    onActivated: (settings) => settings.showBar = !settings.showBar
  }
  SettingsShortcut {
    name: "showBar"
    description: "Show the bar"

    onActivated: (settings) => settings.showBar = true
  }
  SettingsShortcut {
    name: "hideBar"
    description: "Hide the bar"

    onActivated: (settings) => settings.showBar = false
  }

  // Power Menu
  SettingsShortcut {
    name: "powerMenu"
    description: "Toggle the power menu"

    onActivated: (settings) => settings.showBar ? settings.toggleBarCenterWidget("powerMenu") : null
  }
  SettingsShortcut {
    name: "showPowerMenu"
    description: "Show the power menu"

    onActivated: (settings) => settings.showBar ? settings.barCenterWidget = "powerMenu" : null
  }
  SettingsShortcut {
    name: "hidePowerMenu"
    description: "Hide the power menu"

    onActivated: (settings) => settings.showBar ? settings.barCenterWidget = "" : null
  }

  // Color Picker
  ColorPickerShortcut {
    colorType: "rgb"
  }
  ColorPickerShortcut {
    colorType: "hex"
  }
  ColorPickerShortcut {
    colorType: "hsl"
  }
  ColorPickerShortcut {
    colorType: "hsv"
  }
  ColorPickerShortcut {
    colorType: "cmyk"
  }
  SettingsShortcut {
    name: "hideColorPicker"
    description: "Hide the color picker"

    onActivated: (settings) => settings.showBar ? settings.barCenterWidget = "" : null
  }

  component Shortcut : GlobalShortcut {
    appid: "meshell"
  }
  component SettingsShortcut : Shortcut {
    signal activated(settings: var)
    property bool released: false

    onPressed: if (!released) activated(SettingsStorage.getForActive())
    onReleased: if (released) activated(SettingsStorage.getForActive())
  }
  component ColorPickerShortcut : SettingsShortcut {
    property string colorType: ""

    name: `pick${colorType.charAt(0).toUpperCase() + colorType.slice(1)}Color`
    description: `Pick a ${colorType.toUpperCase()} color`

    onActivated: (settings) => {
      if (settings.showBar) {
        ColorPicker.pickColor(colorType)

        delayTimer.interval = 500
        delayTimer.callback = () => {
          settings.colorPickerColorType = colorType
          settings.barCenterWidget = ""
          settings.barCenterWidget = "colorPicker"
        }
        delayTimer.start()
      }
    }
  }

  Timer {
    id: delayTimer

    property var callback

    interval: 0
    repeat: false
    onTriggered: callback()
  }
}
