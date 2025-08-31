import qs.components.bar
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

      NumberAnimation {
        target: loader.item
        property: "scale"
        from: 0
        to: 1
        duration: 200
        easing.type: Easing.InOutQuad
      }
      NumberAnimation {
        target: loader.item
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
      }
    }

    onSourceComponentChanged: animation.running = true
  }

  Behavior on implicitWidth {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }
  Behavior on implicitHeight {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutQuad
    }
  }
}
