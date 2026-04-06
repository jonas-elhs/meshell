import qs.config
import qs.modules.bar.components
import qs.components.animations
import QtQuick

Item {
  id: root

  required property var settings
  required property var screen

  property alias center: centerWidget
  property int barWidth
  Component.onCompleted: root.barWidth = Math.max(information.implicitWidth, clock.implicitWidth, performance.implicitWidth, power.implicitWidth)

  opacity: settings.showBar ? 1 : 0

  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.left: parent.left

  anchors.topMargin: Config.layout.gap.size
  anchors.rightMargin: 0
  anchors.leftMargin: settings.showBar ? Config.layout.gap.size : -root.barWidth
  anchors.bottomMargin: Config.layout.gap.size

  // Top
  Information {
    id: information
    width: root.barWidth
  }
  Clock {
    id: clock
    width: root.barWidth

    anchors.top: information.bottom
    anchors.topMargin: Config.layout.gap.size
  }

  // Center
  CenterWidget {
    id: centerWidget
    barWidth: root.barWidth
    settings: root.settings
    screen: root.screen

    anchors.verticalCenter: bar.verticalCenter
  }

  // Bottom
  SystemUsage {
    id: performance
    width: root.barWidth

    anchors.bottom: power.top
    anchors.bottomMargin: Config.layout.gap.size
  }
  Power {
    id: power
    width: root.barWidth
    settings: root.settings

    anchors.bottom: parent.bottom
  }

  Behavior on anchors.leftMargin {
    CustomNumberAnimation {}
  }
  Behavior on opacity {
    CustomNumberAnimation {}
  }
}
