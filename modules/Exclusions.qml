import qs.config
import qs.components
import Quickshell

CustomWindow {
  id: root

  required property var settings
  required property var bar

  name: "exclusions"
  visible: settings.showBar

  anchors.left: true
  margins.left: Config.layout.gap.size

  exclusiveZone: bar.barWidth
  implicitWidth: 1
  implicitHeight: 1
  mask: Region {}

  color: "transparent"
}
