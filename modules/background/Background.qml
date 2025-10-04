import qs.components
import Quickshell
import Quickshell.Wayland

CustomWindow {
  id: root

  required property ShellScreen screen

  name: "background"
  screen: root.screen
  WlrLayershell.layer: WlrLayer.Background
  exclusionMode: ExclusionMode.Ignore
  color: "black"

  anchors.top: true
  anchors.right: true
  anchors.bottom: true
  anchors.left: true

  mask: Region {}

  Wallpaper { }
}
