import qs.config
import qs.components.bar
import qs.components.animations
import QtQuick
import Quickshell.Hyprland

BarModule {
  id: root

  property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values

  verticalPadding: Config.layout.gap.inner * 1.5
  horizontalPadding: 0

  onWheel: (direction, event) => {
    if (direction == "up") {
      Hyprland.dispatch(`workspace e-1`)
    }
    else if (direction == "down") {
      Hyprland.dispatch(`workspace e+1`)
    }
  }

  Repeater {
    id: workspaceRepeater
    model: workspaces

    Rectangle {
      required property HyprlandWorkspace modelData
      readonly property bool focused: (Hyprland.focusedWorkspace?.id ?? -1) == modelData.id
      readonly property int diameter: 10

      anchors.horizontalCenter: parent.horizontalCenter

      implicitWidth: diameter
      implicitHeight: focused ? 100 : diameter
      radius: width / 2
      color: focused ? Config.colors.accent : Config.colors.foreground.base

      // Switch To Workspace On Click
      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`workspace ${workspace.id}`)
      }

      // Animations
      Behavior on implicitHeight {
        CustomNumberAnimation {}
      }
      Behavior on color {
        CustomColorAnimation {}
      }
    }
  }
}
