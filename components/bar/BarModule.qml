import qs.config
import qs.components.animations
import QtQuick

Rectangle {
  id: root

  property int padding: Config.layout.gap.inner
  property int horizontalPadding: padding
  property int verticalPadding: padding
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

  readonly property Item wrapper: root.column == true ? columnWrapper.item : itemWrapper.item
  readonly property int actualHorizontalPadding: styled ? horizontalPadding: 0
  readonly property int actualVerticalPadding: styled ? verticalPadding: 0

  radius: styled ? Config.layout.border.radius.size : 0
  color: styled ? `#${Config.layout.background.opacity_hex}${Config.colors.background.base.substring(1)}` : "transparent"
  border.width: styled ? Config.layout.border.width : 0
  border.color: hoverState.hovered || alwaysBorder ? Config.colors.accent : Config.colors.inactive

  implicitWidth: wrapper.implicitWidth + 2 * actualHorizontalPadding
  implicitHeight: wrapper.implicitHeight + 2 * actualVerticalPadding

  // Display Children In Column
  default property list<QtObject> datax
  Loader {
    id: itemWrapper

    active: root.column == false
    anchors.fill: parent
    sourceComponent: Item {
      data: root.datax

      implicitWidth: childrenRect.width
      implicitHeight: childrenRect.height

      anchors.fill: parent
      anchors.topMargin: root.actualVerticalPadding
      anchors.rightMargin: root.actualHorizontalPadding
      anchors.bottomMargin: root.actualVerticalPadding
      anchors.leftMargin: root.actualHorizontalPadding
    }
  }
  Loader {
    id: columnWrapper

    active: root.column == true
    anchors.fill: parent
    sourceComponent: Column {
      data: root.datax

      anchors.fill: parent
      anchors.topMargin: root.actualVerticalPadding
      anchors.rightMargin: root.actualHorizontalPadding
      anchors.bottomMargin: root.actualVerticalPadding
      anchors.leftMargin: root.actualHorizontalPadding
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
