import qs.config
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root

  property bool padding: true
  property bool horizontalPadding: padding
  property bool verticalPadding: padding
  property bool alwaysBorder: false
  property bool styled: true
  signal wheel(direction: string, event: WheelEvent)

  radius: styled ? Config.layout.border.radius.size : 0
  color: styled ? `#${Config.layout.background.opacity_hex}${Config.colors.background.base.substring(1)}` : "transparent"
  border.width: styled ? Config.layout.border.width : 0
  border.color: hoverState.hovered || alwaysBorder ? Config.colors.accent : Config.colors.inactive

  implicitWidth: wrapper.implicitWidth + (horizontalPadding ? 2 * Config.layout.gap.inner : 0)
  implicitHeight: wrapper.implicitHeight + (verticalPadding ? 2 * Config.layout.gap.inner : 0)

  // Display Children In Column
  default property alias data: wrapper.data
  ColumnLayout {
    id: wrapper

    anchors.fill: parent
    anchors.topMargin: verticalPadding && styled ? Config.layout.gap.inner : 0
    anchors.rightMargin: horizontalPadding && styled ? Config.layout.gap.inner : 0
    anchors.bottomMargin: verticalPadding && styled ? Config.layout.gap.inner : 0
    anchors.leftMargin: horizontalPadding && styled ? Config.layout.gap.inner : 0
    spacing: Config.layout.gap.inner
  }

  // Border Change On Hover
  HoverHandler {
    id: hoverState
  }
  Behavior on border.color {
    ColorAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }

  WheelHandler {
    enabled: true
    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    onWheel: (event) => {
      const angleY = event.angleDelta.y
      const direction = angleY == 120 ? "up" : angleY == -120 ? "down" : ""

      root.wheel(direction, event)
    }
  }
}
