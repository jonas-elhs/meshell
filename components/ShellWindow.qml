import qs.io
import qs.config
import qs.modules
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

CustomWindow {
  id: root

  required property var settings
  required property var bar
  required property var notifications

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
    regions: [...barRegions.instances, ...notificationRegions.instances]
  }
  Variants {
    id: barRegions
    model: root.bar.children

    Region {
      required property Item modelData

      item: modelData
    }
  }
  Variants {
    id: notificationRegions
    model: [...Array(notifications.list.count).keys()]

    Region {
      required property int modelData

      item: notifications.list.itemAtIndex(modelData)
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
