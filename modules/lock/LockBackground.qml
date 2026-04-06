import qs.io
import qs.config
import qs.modules
import qs.components
import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland

CustomWindow {
  id: root

  required property var barCenter
  required property var settings

  anchors.top: true
  anchors.right: true
  anchors.bottom: true
  anchors.left: true

  mask: Region {}
  color: "transparent"
  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Overlay

  name: "lock-background"

  ClippingRectangle {
    id: clip

    anchors.verticalCenter: parent.verticalCenter
    color: "transparent"
    opacity: GlobalSettings.locked ? 1 : 0

    radius: root.barCenter.radius
    width: root.barCenter.width
    height: root.barCenter.height
    x: root.barCenter.x

    Image {
      id: image

      x: 0 - clip.x
      y: 0 - clip.y
      width: root.width
      height: root.height + 1

      source: Wallpapers.current
      fillMode: Image.PreserveAspectCrop
    }
  }
}
