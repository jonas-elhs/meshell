import qs.config
import qs.components.animations
import QtQuick

Rectangle {
  id: root

  property bool padding: true
  property bool horizontalPadding: padding
  property bool verticalPadding: padding
  property bool alwaysBorder: false
  property bool styled: true
  property int acceptedButtons: Qt.AllButtons
  property int spacing: Config.layout.gap.inner
  property bool column: true
  signal wheel(direction: string, event: WheelEvent)
  signal leftClicked(MouseEvent event)
  signal middleClicked(MouseEvent event)
  signal rightClicked(MouseEvent event)
  signal clicked(event: MouseEvent)

  readonly property int childrenWidth: root.column ? columnWrapper.item.implicitWidth : itemWrapper.item.implicitWidth
  readonly property int childrenHeight: root.column ? columnWrapper.item.implicitHeight : itemWrapper.item.implicitHeight

  radius: styled ? Config.layout.border.radius.size : 0
  color: styled ? `#${Config.layout.background.opacity_hex}${Config.colors.background.base.substring(1)}` : "transparent"
  border.width: styled ? Config.layout.border.width : 0
  border.color: hoverState.hovered || alwaysBorder ? Config.colors.accent : Config.colors.inactive

  implicitWidth: childrenWidth + (horizontalPadding ? 2 * Config.layout.gap.inner : 0)
  implicitHeight: childrenHeight + (verticalPadding ? 2 * Config.layout.gap.inner : 0)

  // Display Children In Column
  default property list<QtObject> datax
  Loader {
    id: itemWrapper

    active: root.column == false
    anchors.fill: parent
    sourceComponent: Item {
      data: root.datax

      anchors.fill: parent
      anchors.topMargin: verticalPadding && styled ? Config.layout.gap.inner : 0
      anchors.rightMargin: horizontalPadding && styled ? Config.layout.gap.inner : 0
      anchors.bottomMargin: verticalPadding && styled ? Config.layout.gap.inner : 0
      anchors.leftMargin: horizontalPadding && styled ? Config.layout.gap.inner : 0
    }
  }
  Loader {
    id: columnWrapper

    active: root.column == true
    anchors.fill: parent
    sourceComponent: Column {
      data: root.datax

      anchors.fill: parent
      anchors.topMargin: verticalPadding && styled ? Config.layout.gap.inner : 0
      anchors.rightMargin: horizontalPadding && styled ? Config.layout.gap.inner : 0
      anchors.bottomMargin: verticalPadding && styled ? Config.layout.gap.inner : 0
      anchors.leftMargin: horizontalPadding && styled ? Config.layout.gap.inner : 0
      spacing: root.spacing
    }
  }

  // Border Change On Hover
  HoverHandler {
    id: hoverState
  }
  Behavior on border.color {
    CustomColorAnimation {}
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

  MouseArea {
    anchors.fill: parent
    propagateComposedEvents: true

    acceptedButtons: root.acceptedButtons
    onClicked: (event) => {
      event.accepted = false

      switch (event.button) {
        case Qt.LeftButton:
          root.leftClicked(event)
          break
        case Qt.MiddleButton:
          root.middleClicked(event)
          break
        case Qt.RightButton:
          root.rightClicked(event)
          break
      }

      root.clicked(event)
    }
  }
}
