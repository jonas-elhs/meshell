import qs.io
import qs.config
import qs.components.bar
import Quickshell
import QtQuick
import QtQuick.Layouts

BarModule {
  id: root

  required property var settings
  property string colorType: settings.colorPickerColorType
  property string color: ColorPicker.color
  property list<string> formattedColor: {
    const split = root.color.split(" ")

    switch (settings?.colorPickerColorType ?? "") {
      case "hex":
       const value = color.slice(1)
       return [ value.slice(0, 2), value.slice(2, 4), value.slice(4, 6) ]
      case "rgb":
      case "hsl":
      case "hsv":
        return split
      default:
       return color
    }
  }


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
      model: root.formattedColor

      BarItem {
        required property string modelData

        text: modelData
      }
    }
  }

  Rectangle {
    visible: root.colorType == "hex"

    width: header.width
    height: width
    color: root.color
    radius: Config.layout.border.radius.inner

    Layout.alignment: Qt.AlignHCenter
  }
}
