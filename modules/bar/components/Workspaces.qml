import qs.config
import qs.components.bar
import qs.components.animations
import QtQuick
import Quickshell.Hyprland

BarModule {
  id: root

  property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
  property bool showNumber: false

  onWheel: (direction, event) => {
    if (direction == "up") {
      Hyprland.dispatch(`workspace e-1`)
    }
    else if (direction == "down") {
      Hyprland.dispatch(`workspace e+1`)
    }
  }

  // TODO: Add top and bottom extra margin of 4 px
  Repeater {
    id: workspaceRepeater
    model: workspaces

    Rectangle {
      property HyprlandWorkspace workspace: workspaces[index]
      readonly property bool focused: Hyprland.focusedWorkspace.id == workspace.id
      readonly property int diameter: 10

      anchors.horizontalCenter: parent.horizontalCenter

      implicitWidth: diameter
      implicitHeight: focused ? 100 : diameter
      radius: width / 2
      color: focused ? Config.colors.accent : Config.colors.foreground.base

      Text {
        text: showNumber ? workspace.id : ""
        font.pixelSize: 8

        anchors.centerIn: parent
      }

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
