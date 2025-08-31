import qs.config
import qs.modules.bar.components
import QtQuick

Item {
  id: bar

  required property var settings

  property int barWidth
  Component.onCompleted: bar.barWidth = Math.max(information.implicitWidth, clock.implicitWidth, performance.implicitWidth)

  opacity: settings.showBar ? 1 : 0

  Behavior on anchors.leftMargin {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }
  Behavior on opacity {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }

  anchors {
    topMargin: Config.layout.gap.size
    rightMargin: 0
    leftMargin: settings.showBar ? Config.layout.gap.size : -barWidth
    bottomMargin: Config.layout.gap.size

    top: parent.top
    bottom: parent.bottom
    left: parent.left
  }

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
