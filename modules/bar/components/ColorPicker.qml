import qs.io
import qs.config
import qs.components.bar
import Quickshell
import QtQuick

BarModule {
  id: root

  required property var settings
  property string colorType: settings.colorPickerColorType
  property string color: ColorPicker.color

  acceptedButtons: Qt.LeftButton | Qt.RightButton
  onLeftClicked: Quickshell.execDetached([ "wl-copy", root.color ])
  onClicked: root.settings.barCenterWidget = ""

  BarGroup {
    id: header

    BarItem {
      text: root.colorType.toUpperCase()
    }
    BarItem {
      text: "color"
      textSize: Config.layout.font.sub
    }
    BarItem {
      text: "picked"
      textSize: Config.layout.font.sub
    }
  }

  BarGroup {
    Repeater {
      model: ColorPicker.formattedColor

      BarItem {
        required property string modelData

        text: modelData
      }
    }
  }

  Rectangle {
    width: header.width
    height: width
    color: ColorPicker.previewColor
    radius: Config.layout.border.radius.inner

    anchors.horizontalCenter: parent.horizontalCenter
  }

  Timer {
    running: true
    interval: 10000
    onTriggered: settings.barCenterWidget = ""
  }
}
