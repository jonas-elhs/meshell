import qs.config
import qs.components
import qs.components.bar
import qs.components.animations
import Quickshell
import QtQuick

BarModule {
  id: root

  required property var settings

  Component.onCompleted: shutdown.forceActiveFocus()

  PowerButton {
    id: suspend
    icon: "stop_circle"
    command: "systemctl suspend"

    KeyNavigation.up: lock
    KeyNavigation.down: hibernate
  }
  PowerButton {
    id: hibernate
    icon: "save"
    command: "systemctl hibernate"

    KeyNavigation.up: suspend
    KeyNavigation.down: shutdown
  }
  PowerButton {
    id: shutdown
    icon: "power_settings_new"
    command: "systemctl poweroff"

    KeyNavigation.up: hibernate
    KeyNavigation.down: reboot
  }
  PowerButton {
    id: reboot
    icon: "cached"
    command: "systemctl reboot"

    KeyNavigation.up: shutdown
    KeyNavigation.down: lock
  }
  PowerButton {
    id: lock
    icon: "lock"
    command: "sleep 0.2 && loginctl lock-session"

    KeyNavigation.up: reboot
    KeyNavigation.down: suspend
  }

  component PowerButton : Rectangle {
    id: button

    property string icon
    property string command

    function execute() {
      Quickshell.execDetached([ "sh", "-c", command ])

      root.settings.barCenterWidget = ""
    }

    width: 100
    height: width
    radius: Config.layout.border.radius.inner
    color: "transparent"
    border.width: Config.layout.border.width
    border.color: activeFocus ? Config.colors.accent : "transparent"

    Keys.onEnterPressed: execute()
    Keys.onReturnPressed: execute()
    Keys.onEscapePressed: root.settings.barCenterWidget = ""
    Keys.onPressed: event => {
      if (event.key === Qt.Key_J && KeyNavigation.down) {
        KeyNavigation.down.focus = true
        event.accepted = true
      } else if (event.key === Qt.Key_K && KeyNavigation.up) {
        KeyNavigation.up.focus = true
        event.accepted = true
      }
    }

    MaterialIcon {
      icon: button.icon
      color: Config.colors.foreground.base
      // color: button.focus ? Config.colors.accent : Config.colors.foreground.base
      size: 50
      weight: 700
      anchors.centerIn: parent

      Behavior on color {
        CustomColorAnimation {}
      }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: execute()
    }
    HoverHandler {
      id: hoverState
      onHoveredChanged: button.focus = true
    }

    Behavior on border.color {
      CustomColorAnimation {}
    }
  }
}
