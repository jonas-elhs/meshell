pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
  property var screenSettings: new Map()

  function save(screen: ShellScreen, settings: var) {
    screenSettings.set(Hyprland.monitorFor(screen), settings)
  }

  function getForActive() {
    return screenSettings.get(Hyprland.focusedMonitor)
  }
}
