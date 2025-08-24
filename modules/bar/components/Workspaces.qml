import qs.config
import qs.components.bar
import QtQuick
import QtQuick.Layouts
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

  Repeater {
    id: workspaceRepeater
    model: workspaces

    Rectangle {
      property HyprlandWorkspace workspace: workspaces[index]
      readonly property bool focused: Hyprland.focusedWorkspace.id == workspace.id
      readonly property int diameter: 10

      Layout.topMargin: workspace == workspaces[0] ? 4 : 0
      Layout.bottomMargin: workspace == workspaces[workspaces.length - 1] ? 4 : 0
      Layout.alignment: Qt.AlignHCenter

      Layout.preferredWidth: diameter
      Layout.preferredHeight: focused ? 100 : diameter
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
      Behavior on Layout.preferredHeight {
        NumberAnimation {
          duration: 200;
          easing.type: Easing.InOutQuad
        }
      }
      Behavior on color {
        ColorAnimation {
          duration: 200
          easing.type: Easing.InOutQuad
        }
      }
    }
  }
}
