import qs.io
import Quickshell.Hyprland
import Quickshell

Scope {
  id: root

  // Bar
  VisibilityShortcut {
    name: "bar"
    description: "Toggle the bar"

    onActivated: (visibilities) => visibilities.bar = !visibilities.bar
  }
  VisibilityShortcut {
    name: "showBar"
    description: "Show the bar"

    onActivated: (visibilities) => visibilities.bar = true
  }
  VisibilityShortcut {
    name: "hideBar"
    description: "Hide the bar"

    onActivated: (visibilities) => visibilities.bar = false
  }

  // Power Menu
  VisibilityShortcut {
    name: "powerMenu"
    description: "Toggle the power menu"

    onActivated: (visibilities) => visibilities.bar ? visibilities.toggleBarCenterWidget("powerMenu") : null
  }
  VisibilityShortcut {
    name: "showPowerMenu"
    description: "Show the power menu"

    onActivated: (visibilities) => visibilities.bar ? visibilities.barCenterWidget = "powerMenu" : null
  }
  VisibilityShortcut {
    name: "hidePowerMenu"
    description: "Hide the power menu"

    onActivated: (visibilities) => visibilities.bar ? visibilities.barCenterWidget = "" : null
  }

  component Shortcut : GlobalShortcut {
    appid: "meshell"
  }
  component VisibilityShortcut : Shortcut {
    signal activated(visibilities: var)
    property bool released: false

    onPressed: if (!released) activated(VisibilitiesStorage.getForActive())
    onReleased: if (released) activated(VisibilitiesStorage.getForActive())
  }
}
