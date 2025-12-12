import qs.config
import qs.io
import qs.modules
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

CustomWindow {
  id: root

  required property var settings

  WlrLayershell.namespace: "meshell-shell"
  WlrLayershell.layer: GlobalSettings.locked ? WlrLayer.Overlay : WlrLayer.Top

  // Span Whole Screen
  anchors.top: true
  anchors.right: true
  anchors.bottom: true
  anchors.left: true
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
    id: grab
    active: root.settings.barCenterWidget == "powerMenu"
    windows: [root]
    onCleared: {
      root.settings.barCenterWidget = "";
    }
  }
}
