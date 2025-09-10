import qs.components
import Quickshell
import Quickshell.Wayland

CustomWindow {
  id: root

  required property ShellScreen screen
  required property var settings

  name: "background"
  screen: root.screen
  WlrLayershell.layer: WlrLayer.Background
  exclusionMode: ExclusionMode.Ignore
  color: "white"

  anchors.top: true
  anchors.right: true
  anchors.bottom: true
  anchors.left: true

  mask: Region {}

  Wallpaper {
    settings: root.settings
  }
}
