import qs.config
import Quickshell

PanelWindow {
  id: root

  required property var visibilities

  visible: visibilities.bar

  anchors.left: true
  margins.left: Config.layout.gap.size

  exclusiveZone: bar.barWidth
  implicitWidth: 1
  implicitHeight: 1
  mask: Region {}

  color: "transparent"
}
