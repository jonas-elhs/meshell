import qs.config
import qs.components.bar
import qs.components.animations
import QtQuick
import Quickshell.Hyprland

BarModule {
  id: root

  property int workspaces: Hyprland.workspaces.values.length >= 5 ? Hyprland.workspaces.values.length : 5

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
      property int workspaceId: Hyprland.workspaces.values[index]?.id ?? -1
      property bool focused: (Hyprland.focusedWorkspace?.id ?? -1) == workspaceId
      property int diameter: 10

      anchors.horizontalCenter: parent.horizontalCenter

      implicitWidth: diameter
      implicitHeight: focused ? 100 : diameter
      radius: width / 2
      color: focused ? Config.colors.accent : Config.colors.foreground.base

      // Switch To Workspace On Click
      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`workspace ${modelData.id}`)
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
