pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
  property var screenVisibilities: new Map()

  function save(screen: ShellScreen, visibilities: var) {
    screenVisibilities.set(Hyprland.monitorFor(screen), visibilities)
  }

  function getForActive() {
    return screenVisibilities.get(Hyprland.focusedMonitor)
  }
}
