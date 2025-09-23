import qs.config
import qs.components.animations
import qs.modules.bar.components
import QtQuick

Item {
  id: bar

  required property var settings
  required property var screen

  property alias center: centerWidget
  property int barWidth
  Component.onCompleted: bar.barWidth = Math.max(information.implicitWidth, clock.implicitWidth, performance.implicitWidth, performance.implicitWidth)

  opacity: settings.showBar ? 1 : 0

  Behavior on anchors.leftMargin {
    CustomNumberAnimation {}
  }
  Behavior on opacity {
    CustomNumberAnimation {}
  }

  anchors.topMargin: Config.layout.gap.size
  anchors.rightMargin: 0
  anchors.leftMargin: settings.showBar ? Config.layout.gap.size : -barWidth
  anchors.bottomMargin: Config.layout.gap.size

  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.left: parent.left

  Information {
    id: information
    width: bar.barWidth
  }
  Clock {
    id: clock
    width: bar.barWidth

    anchors.top: information.bottom
    anchors.topMargin: Config.layout.gap.size
  }

  CenterWidget {
    id: centerWidget
    bar: bar
    settings: bar.settings
    screen: bar.screen

    anchors.verticalCenter: bar.verticalCenter
  }

  SystemUsage {
    id: performance
    width: bar.barWidth

    anchors.bottom: power.top
    anchors.bottomMargin: Config.layout.gap.size
  }
  Power {
    id: power
    width: bar.barWidth
    settings: bar.settings

    anchors.bottom: parent.bottom
  }
}
