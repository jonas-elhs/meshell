import qs.components.bar
import qs.components.animations
import Quickshell
import QtQuick

BarModule {
  id: root

  default property list<WidgetComponent> components: []
  readonly property Component conditionalComponent: components.find((component) => component.condition)?.component ?? null
  readonly property Component defaultComponent: components.find((component) => component.isDefault)?.component ?? null
  readonly property Component activeComponent: conditionalComponent ?? defaultComponent ?? null

  padding: loader.item.padding
  horizontalPadding: loader.item.horizontalPadding
  verticalPadding: loader.item.verticalPadding
  alwaysBorder: loader.item.alwaysBorder
  acceptedButtons: loader.item.acceptedButtons
  spacing: loader.item.spacing
  onWheel: loader.item.onWheel
  onLeftClicked: loader.item.onLeftClicked
  onMiddleClicked: loader.item.onMiddleClicked
  onRightClicked: loader.item.onRightClicked
  onClicked: loader.item.onClicked

  Loader {
    id: loader

    sourceComponent: activeComponent
    onSourceComponentChanged: animation.running = true

    ParallelAnimation {
      id: animation

      CustomNumberAnimation {
        target: loader.item
        property: "scale"
        from: 0
        to: 1
      }
      CustomNumberAnimation {
        target: loader.item
        property: "opacity"
        from: 0
        to: 1
        duration: 400
      }
    }
  }

  Behavior on implicitWidth {
    CustomNumberAnimation {}
  }
  Behavior on implicitHeight {
    CustomNumberAnimation {}
  }
}
