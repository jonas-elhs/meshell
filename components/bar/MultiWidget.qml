import qs.components.bar
import qs.components.animations
import Quickshell
import QtQuick
import QtQuick.Layouts

BarModule {
  id: root

  default property list<WidgetComponent> components
  readonly property Component conditionalComponent: components.find((component) => component.condition)?.component ?? null
  readonly property Component defaultComponent: components.find((component) => component.isDefault)?.component ?? null
  readonly property Component activeComponent: conditionalComponent ?? defaultComponent ?? null

  implicitWidth: loader.implicitWidth
  implicitHeight: loader.implicitHeight

  Loader {
    id: loader

    Layout.fillWidth: true
    Layout.fillHeight: true
    sourceComponent: activeComponent

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

    onSourceComponentChanged: animation.running = true
  }

  Behavior on implicitWidth {
    CustomNumberAnimation {}
  }
  Behavior on implicitHeight {
    CustomNumberAnimation {}
  }
}
