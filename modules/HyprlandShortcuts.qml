import qs.io
import Quickshell.Hyprland
import Quickshell

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

  component Shortcut : GlobalShortcut {
    appid: "meshell"
  }
  component SettingsShortcut : Shortcut {
    signal activated(settings: var)
    property bool released: false

    onPressed: if (!released) activated(SettingsStorage.getForActive())
    onReleased: if (released) activated(SettingsStorage.getForActive())
  }
}
