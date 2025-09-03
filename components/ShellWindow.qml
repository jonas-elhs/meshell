import qs.config
import qs.io
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

PanelWindow {
  id: root

  required property var settings

  // Span Whole Screen
  anchors {
    top: true
    right: true
    bottom: true
    left: true
  }
  exclusionMode: ExclusionMode.Ignore

  // Only Click On Children
  mask: Region {
    regions: regions.instances
  }
  Variants {
    id: regions
    // FIX: target all children
    model: bar.children

    Region {
      required property Item modelData

      x: modelData.x + Config.layout.gap.size
      y: modelData.y + 20
      width: modelData.width
      height: modelData.height
    }
  }
  color: "transparent"

  // Keyboard Focus
  WlrLayershell.keyboardFocus: root.settings.barCenterWidget == "" ? WlrKeyboardFocus.None : WlrKeyboardFocus.OnDemand
  HyprlandFocusGrab {
    active: root.settings.barCenterWidget == "powerMenu"
    id: grab
    windows: [ root ]
    onCleared: {
      root.settings.barCenterWidget = ""
    }
  }
}
