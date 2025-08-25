import qs.config
import Quickshell

PanelWindow {
  id: root

  required property var settings
  required property var bar

  visible: settings.showBar

  anchors.left: true
  margins.left: Config.layout.gap.size

  exclusiveZone: bar.barWidth
  implicitWidth: 1
  implicitHeight: 1
  mask: Region {}

  color: "transparent"
}
